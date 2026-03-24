from flask import Blueprint, render_template, request, jsonify, session, redirect, url_for, flash
from utils import calculer_rang, niveau_requis
from moteur_codexia import evaluer_code

from models.parcours_model import (get_track_by_slug, get_exercices_by_track, 
                                   get_user_progress, get_exercice_by_slug, 
                                   get_exercice_for_validation, enregistrer_soumission, 
                                   valider_exercice_et_donner_xp, get_user_track_xp)
from models.profil_model import get_user_by_id

parcours_bp = Blueprint('parcours', __name__)

@parcours_bp.route('/parcours/<slug>')
def parcours(slug):
    track = get_track_by_slug(slug)
    if not track:
        flash("Ce parcours n'existe pas encore !", "error")
        return redirect(url_for('main.accueil'))

    liste_exercices = get_exercices_by_track(track['id_track'])
    
    user_info = None
    user_progress = {}

    if 'user_id' in session:
        db_user = get_user_by_id(session['user_id'])
        if db_user:
            # ⚠️ NOUVEAUTÉ : On calcule le rang spécifiquement pour CE parcours en lui passant le nom du langage
            track_xp = get_user_track_xp(session['user_id'], track['id_track'])
            track_rang = calculer_rang(track_xp, track_name=track['name'])
            
            # (Optionnel mais propre) On calcule le rang global au cas où tu en aurais besoin dans ta barre de navigation
            rang_global = calculer_rang(db_user['global_xp'], track_name='global')
            
            user_info = {
                "username": db_user['username'],
                "global_xp": db_user['global_xp'], # Toujours là au cas où
                "track_xp": track_xp,              # L'XP spécifique
                "titre_rang": track_rang["titre"], # Le rang sur CE langage
                "niveau_actuel": track_rang["niveau"], # Le niveau numérique pour débloquer
                "role": db_user['role']
            }
            user_progress = get_user_progress(session['user_id'])
            
    for exo in liste_exercices:
        exo['niveau_requis_num'] = niveau_requis(exo['grade_exercice'])
        
        if not user_info:
            exo['statut_visuel'] = 'locked'
        elif user_info['role'] != 'admin' and exo['niveau_requis_num'] > user_info['niveau_actuel']:
            exo['statut_visuel'] = 'locked'
        else:
            etat_db = user_progress.get(exo['id_exercice'])
            if etat_db == 'termine':
                exo['statut_visuel'] = 'completed'
            elif etat_db == 'en_cours':
                exo['statut_visuel'] = 'in_progress'
            else:
                exo['statut_visuel'] = 'available'

    return render_template('parcours.html', exercices=liste_exercices, user=user_info, track_name=track['name'])


@parcours_bp.route('/exercice/<chemin_url>')
def afficher_exercice(chemin_url):
    exercice = get_exercice_by_slug(chemin_url)
    if exercice is None:
        return "Erreur 404 : Exercice introuvable dans la base de données.", 404
    return render_template('exercice.html', exercice=exercice)

@parcours_bp.route('/api/soumettre', methods=['POST'])
def soumettre_code():
    if 'user_id' not in session:
        return jsonify({"status": "failed", "output": "Tu dois être connecté pour valider un exercice."}), 401

    data = request.json
    code_utilisateur = data.get('code')
    id_exercice = data.get('id_exercice')
    id_utilisateur = session['user_id'] 

    if not code_utilisateur or not id_exercice:
        return jsonify({"status": "failed", "output": "Données manquantes."}), 400

    exo = get_exercice_for_validation(id_exercice)
    if not exo:
        return jsonify({"status": "failed", "output": "Exercice introuvable dans la BDD."}), 404

    # On détermine le langage selon l'id_track (1 = Python, 2 = JS, 3 = SQL)
    langage_choisi = 'sql' if exo['id_track'] == 3 else ('javascript' if exo['id_track'] == 2 else 'python')
    # On passe l'argument 'langage' à notre moteur
    resultat = evaluer_code(code_utilisateur, exo['test_code'], langage=langage_choisi)
    
    db_status = 'success' if resultat['status'] == 'success' else 'failed'
    
    # Sauvegarde en base de données
    enregistrer_soumission(id_utilisateur, id_exercice, code_utilisateur, db_status, resultat['output'])

    if resultat['status'] == 'success':
        valider_exercice_et_donner_xp(id_utilisateur, id_exercice, exo['xp_reward'])
        # Optionnel : Mettre à jour la session immédiatement pour l'affichage visuel
        session['xp'] = session.get('xp', 0) + exo['xp_reward']

    return jsonify(resultat)
