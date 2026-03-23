from flask import Blueprint, render_template, session
from utils import calculer_rang
from models.main_model import get_active_tracks
from models.profil_model import get_user_by_id

main_bp = Blueprint('main', __name__)

@main_bp.route('/')
def accueil():
    user_info = None
    if 'user_id' in session:
        db_user = get_user_by_id(session['user_id'])
        if db_user:
            rang = calculer_rang(db_user['global_xp'])
            user_info = {
                "username": db_user['username'],
                "xp": db_user['global_xp'],
                "titre_rang": rang["titre"],
                "niveau_actuel": rang["niveau"],
                "role": db_user['role'],
                "avatar_url": db_user['avatar_url']
            }

    tracks = get_active_tracks()
    return render_template('index.html', user=user_info, tracks=tracks)