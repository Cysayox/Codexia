import subprocess
import tempfile
import os
import sqlite3

def evaluer_sql(requete_eleve, test_code):
    """Évalue une requête SQL en utilisant une base SQLite en mémoire."""
    # 1. On sépare le script de préparation et la requête attendue
    try:
        script_creation, requete_solution = test_code.split('---')
        script_creation = script_creation.strip()
        requete_solution = requete_solution.strip()
    except ValueError:
        return {"status": "failed", "output": "Erreur interne : Le test de l'exercice est mal formaté (manque le séparateur ---)."}

    # 2. On crée la BDD en RAM
    conn = sqlite3.connect(':memory:')
    cursor = conn.cursor()
    
    try:
        # 3. Préparation du terrain (Tables + Fausses données)
        cursor.executescript(script_creation)
        
        # 4. On regarde ce que le prof attend
        cursor.execute(requete_solution)
        resultat_attendu = cursor.fetchall()
        
        # 5. On teste la requête de l'élève
        cursor.execute(requete_eleve)
        resultat_eleve = cursor.fetchall()
        
        # 6. Verdict !
        if resultat_eleve == resultat_attendu:
            return {"status": "success", "output": "✅ SUCCÈS : Ta requête a renvoyé exactement les bonnes données !"}
        else:
            return {"status": "failed", "output": f"❌ ÉCHEC : Les données renvoyées sont incorrectes.\n\nAttendu :\n{resultat_attendu}\n\nObtenu avec ta requête :\n{resultat_eleve}"}
            
    except sqlite3.Error as e:
        return {"status": "failed", "output": f"⚠️ Erreur de syntaxe SQL : {e}"}
    finally:
        conn.close()

def evaluer_code(code_utilisateur, code_test, langage='python'):
    """Le routeur principal du moteur d'exécution."""
    
    # --- ROUTAGE SQL ---
    if langage == 'sql':
        return evaluer_sql(code_utilisateur, code_test)

    # --- ROUTAGE PYTHON / JS ---
    code_complet = code_utilisateur + "\n\n" + code_test
    extension = '.js' if langage == 'javascript' else '.py'

    with tempfile.NamedTemporaryFile(mode='w', suffix=extension, delete=False, encoding='utf-8') as temp_file:
        temp_file.write(code_complet)
        temp_file_path = temp_file.name

    try:
        commande = ['node', temp_file_path] if langage == 'javascript' else ['python', temp_file_path]
        resultat = subprocess.run(commande, capture_output=True, text=True, timeout=3)
        
        if resultat.returncode == 0:
            return {"status": "success", "output": resultat.stdout.strip()}
        else:
            return {"status": "failed", "output": resultat.stderr.strip()}
            
    except subprocess.TimeoutExpired:
        return {"status": "failed", "output": "Erreur : Temps d'exécution dépassé."}
    finally:
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)
