import os
from flask import Blueprint, render_template, request, redirect, url_for, flash, session, current_app
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from utils import calculer_rang, allowed_file, obtenir_titres_et_badges # ⚠️ NOUVEL IMPORT ICI
from models.profil_model import (get_user_by_id, get_historique_user, 
                                 update_profil_base, update_password, 
                                 update_avatar, delete_utilisateur, get_user_stats_by_track)

# Création du Blueprint pour le profil
profil_bp = Blueprint('profil', __name__)

@profil_bp.route('/profil')
def profil():
    if 'user_id' not in session:
        flash("Tu dois être connecté pour voir ton profil.", "error")
        return redirect(url_for('auth.connexion'))

    user_id = session['user_id']
    
    # On utilise nos fonctions SQL du Modèle
    user_db = get_user_by_id(user_id)
    historique = get_historique_user(user_id)
    
    stats_tracks = get_user_stats_by_track(user_id)
    
    # ⚠️ NOUVEAUTÉ : Initialisation des compteurs d'XP pour les badges
    python_xp = 0
    js_xp = 0
    sql_xp = 0
    
    for stat in stats_tracks:
        stat['rang_info'] = calculer_rang(stat['xp'], track_name=stat['track_name'])
        
        # On intercepte l'XP de chaque langage pour nos médailles
        track_name_lower = stat['track_name'].lower()
        if track_name_lower == 'python':
            python_xp = stat['xp']
        elif track_name_lower == 'javascript':
            js_xp = stat['xp']
        elif track_name_lower == 'sql':
            sql_xp = stat['xp']

    # On précise 'global' pour le rang général du joueur (avec les 10 nouveaux paliers)
    rang_info = calculer_rang(user_db['global_xp'], track_name='global')
    
    # ⚠️ NOUVEAUTÉ : Génération des 10 Titres et des 3 Badges !
    recompenses = obtenir_titres_et_badges(user_db['global_xp'], python_xp, js_xp, sql_xp)
    
    user_info = {
        "username": user_db['username'],
        "email": user_db['email'],
        "xp": user_db['global_xp'],
        "titre_rang": rang_info["titre"],
        "niveau_actuel": rang_info["niveau"],
        "date_inscription": user_db['created_at'].strftime("%d/%m/%Y") if user_db['created_at'] else "Inconnue",
        "avatar_url": user_db['avatar_url']
    }

    # On ajoute recompenses=recompenses au rendu du template
    return render_template('profil.html', user=user_info, historique=historique, stats_tracks=stats_tracks, recompenses=recompenses)


@profil_bp.route('/profil/modifier', methods=['GET', 'POST'])
def modifier_profil():
    if 'user_id' not in session:
        return redirect(url_for('auth.connexion'))
        
    user_id = session['user_id']
    
    if request.method == 'POST':
        nouveau_pseudo = request.form.get('username')
        nouvel_email = request.form.get('email')
        mdp_actuel = request.form.get('current_password')
        nouveau_mdp = request.form.get('new_password')
        confirm_mdp = request.form.get('confirm_password')
        avatar = request.files.get('avatar')
        
        user_actuel = get_user_by_id(user_id)
        
        # 1. Mise à jour des infos de base
        succes, msg = update_profil_base(user_id, nouveau_pseudo, nouvel_email)
        if not succes:
            flash(msg, "error")
            return redirect(url_for('profil.modifier_profil')) 
        
        # 2. Gestion du mot de passe
        if mdp_actuel:
            if check_password_hash(user_actuel['password_hash'], mdp_actuel):
                if nouveau_mdp and nouveau_mdp == confirm_mdp:
                    new_hash = generate_password_hash(nouveau_mdp)
                    update_password(user_id, new_hash)
                else:
                    flash("Les nouveaux mots de passe ne correspondent pas.", "error")
                    return redirect(url_for('profil.modifier_profil'))
            else:
                flash("Ton mot de passe actuel est incorrect.", "error")
                return redirect(url_for('profil.modifier_profil'))
        
        # 3. Gestion de l'avatar
        if avatar and avatar.filename != '' and allowed_file(avatar.filename):
            os.makedirs(current_app.config['UPLOAD_FOLDER'], exist_ok=True)
            filename = secure_filename(f"user_{user_id}_{avatar.filename}")
            filepath = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
            avatar.save(filepath)
            
            db_filepath = f"uploads/avatars/{filename}"
            update_avatar(user_id, db_filepath)
            session['avatar_url'] = db_filepath # On met à jour la session

        session['username'] = nouveau_pseudo
        flash("Profil mis à jour avec succès !", "success")
        return redirect(url_for('profil.profil'))

    # Si c'est un simple chargement de page (GET)
    user = get_user_by_id(user_id)
    return render_template('modifier_profil.html', user=user)


@profil_bp.route('/profil/supprimer', methods=['POST'])
def supprimer_profil():
    if 'user_id' not in session:
        return redirect(url_for('auth.connexion'))
        
    user_id = session['user_id']
    username_actuel = session['username']
    username_saisi = request.form.get('confirm_username')
    
    if username_saisi == username_actuel:
        delete_utilisateur(user_id) 
        session.clear()
        # ⚠️ Redirection vers l'accueil du blueprint main
        return redirect(url_for('main.accueil'))
    else:
        flash("Le pseudo saisi ne correspond pas. Suppression annulée.", "error")
        return redirect(url_for('profil.profil'))