from flask import Flask, render_template, request, jsonify, session, redirect, url_for, flash
from werkzeug.security import generate_password_hash, check_password_hash
from db import get_db_connection
from moteur_codexia import evaluer_code

app = Flask(__name__)
# VITAL : Clé secrète pour crypter les cookies de session (à ne jamais partager en production)
app.secret_key = 'une_cle_secrete_tres_complexe_pour_codexia'

# --- LOGIQUE DE GAMIFICATION ---
def calculer_rang(xp):
    """Retourne le rang (texte) et le niveau numérique (1 à 5) selon l'XP."""
    if xp >= 4200: return {"titre": "Maître", "niveau": 5}
    if xp >= 2900: return {"titre": "Expert", "niveau": 4}
    if xp >= 2200: return {"titre": "Avancé", "niveau": 3}
    if xp >= 1300: return {"titre": "Intermédiaire", "niveau": 2}
    return {"titre": "Débutant", "niveau": 1}

def niveau_requis(grade_texte):
    """Convertit le texte du grade de l'exercice en niveau numérique pour comparer."""
    niveaux = {"Débutant": 1, "Intermédiaire": 2, "Avancé": 3, "Expert": 4, "Maître": 5}
    return niveaux.get(grade_texte, 1)

# --- ROUTE 1 : LA PAGE D'ACCUEIL ---
@app.route('/')
def accueil():
    conn = get_db_connection()
    if conn is None:
        return "Erreur critique : Impossible de se connecter à la base de données."

    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id_exercice, title, grade_exercice, xp_reward, theme_chapitre, chemin_url FROM exercice ORDER BY numero_ordre ASC")
    liste_exercices = cursor.fetchall()
    
    # On prépare le dictionnaire utilisateur
    user_info = None
    if 'user_id' in session:
        cursor.execute("SELECT username, global_xp FROM utilisateur WHERE id_utilisateur = %s", (session['user_id'],))
        db_user = cursor.fetchone()
        if db_user:
            rang = calculer_rang(db_user['global_xp'])
            user_info = {
                "username": db_user['username'],
                "xp": db_user['global_xp'],
                "titre_rang": rang["titre"],
                "niveau_actuel": rang["niveau"]
            }
            
    # On ajoute le niveau numérique requis à chaque exercice pour faciliter le blocage HTML
    for exo in liste_exercices:
        exo['niveau_requis_num'] = niveau_requis(exo['grade_exercice'])

    cursor.close()
    conn.close()

    return render_template('index.html', exercices=liste_exercices, user=user_info)

# --- ROUTE : INSCRIPTION ---
@app.route('/inscription', methods=['GET', 'POST'])
def inscription():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        
        # Hachage du mot de passe (comme password_hash en PHP)
        hashed_password = generate_password_hash(password)
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            # On insère le nouvel utilisateur (global_level 1 et global_xp 0 par défaut)
            cursor.execute(
                "INSERT INTO utilisateur (username, email, password_hash, global_level, global_xp) VALUES (%s, %s, %s, 1, 0)",
                (username, email, hashed_password)
            )
            conn.commit()
            flash("Compte créé avec succès ! Tu peux te connecter.", "success")
            return redirect(url_for('connexion'))
        except:
            flash("Erreur : Ce pseudo ou cet email existe déjà.", "error")
        finally:
            cursor.close()
            conn.close()
            
    return render_template('register.html')

# --- ROUTE : CONNEXION ---
@app.route('/connexion', methods=['GET', 'POST'])
def connexion():
    if request.method == 'POST':
        email = request.form['email']
        password_candidate = request.form['password']
        
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM utilisateur WHERE email = %s", (email,))
        user = cursor.fetchone()
        cursor.close()
        conn.close()
        
        # Vérification (comme password_verify en PHP)
        if user and check_password_hash(user['password_hash'], password_candidate):
            # Création de la session (comme $_SESSION en PHP)
            session['user_id'] = user['id_utilisateur']
            session['username'] = user['username']
            session['xp'] = user['global_xp']
            return redirect(url_for('accueil'))
        else:
            flash("Email ou mot de passe incorrect.", "error")
            
    return render_template('login.html')

# --- ROUTE : DÉCONNEXION ---
@app.route('/deconnexion')
def deconnexion():
    session.clear() # On vide la session
    return redirect(url_for('accueil'))

# --- ROUTE 2 : LA PAGE DE L'EXERCICE (L'ARÈNE) ---
@app.route('/exercice/<chemin_url>')
def afficher_exercice(chemin_url):
    conn = get_db_connection()
    if conn is None:
        return "Erreur critique : Base de données inaccessible."

    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM exercice WHERE chemin_url = %s", (chemin_url,))
    exercice = cursor.fetchone()
    
    cursor.close()
    conn.close()

    if exercice is None:
        return "Erreur 404 : Exercice introuvable dans la base de données.", 404

    return render_template('exercice.html', exercice=exercice)

# --- ROUTE 3 : L'API DE CORRECTION (REÇOIT LE CODE ET LE TESTE) ---
@app.route('/api/soumettre', methods=['POST'])
def soumettre_code():
    # VÉRIFICATION DE SÉCURITÉ : L'utilisateur est-il connecté ?
    if 'user_id' not in session:
        return jsonify({"status": "failed", "output": "Tu dois être connecté pour valider un exercice."}), 401

    data = request.json
    code_utilisateur = data.get('code')
    id_exercice = data.get('id_exercice')
    
    # ON UTILISE LE VRAI ID DE LA SESSION
    id_utilisateur = session['user_id'] 

    # ... (le reste de ton code ne change pas) ...

    if not code_utilisateur or not id_exercice:
        return jsonify({"status": "failed", "output": "Données manquantes."}), 400

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # 1. On récupère le test caché ET la récompense en XP
    cursor.execute("SELECT test_code, xp_reward FROM exercice WHERE id_exercice = %s", (id_exercice,))
    exo = cursor.fetchone()

    if not exo:
        cursor.close()
        conn.close()
        return jsonify({"status": "failed", "output": "Exercice introuvable dans la BDD."}), 404

    # 2. Évaluation du code
    resultat = evaluer_code(code_utilisateur, exo['test_code'])

    # 3. Enregistrement dans la table SOUMISSION (Historique)
    db_status = 'success' if resultat['status'] == 'success' else 'failed'
    cursor.execute(
        "INSERT INTO soumission (id_utilisateur, id_exercice, code, status_soumission, test_output) VALUES (%s, %s, %s, %s, %s)",
        (id_utilisateur, id_exercice, code_utilisateur, db_status, resultat['output'][:1000]) # On coupe l'output à 1000 caractères au cas où l'erreur est gigantesque
    )

    # 4. Si c'est un succès, on gère la progression et l'XP
    if resultat['status'] == 'success':
        # On vérifie si l'utilisateur n'avait pas DÉJÀ réussi cet exercice avant (pour ne pas lui donner l'XP à l'infini)
        cursor.execute("SELECT * FROM progresser WHERE id_utilisateur = %s AND id_exercice = %s AND status_progression = 'termine'", (id_utilisateur, id_exercice))
        deja_reussi = cursor.fetchone()

        if not deja_reussi:
            # Il réussit pour la première fois !
            # A. On valide l'exercice dans 'progresser'
            cursor.execute(
                "INSERT INTO progresser (id_utilisateur, id_exercice, status_progression, completed_at) VALUES (%s, %s, 'termine', NOW()) "
                "ON DUPLICATE KEY UPDATE status_progression = 'termine', completed_at = NOW()",
                (id_utilisateur, id_exercice)
            )
            # B. On lui donne son XP !
            cursor.execute(
                "UPDATE utilisateur SET global_xp = global_xp + %s WHERE id_utilisateur = %s",
                (exo['xp_reward'], id_utilisateur)
            )
    
    # On valide les changements dans la base de données
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify(resultat)

# --- LANCEMENT DU SERVEUR ---
if __name__ == '__main__':
    app.run(debug=True)