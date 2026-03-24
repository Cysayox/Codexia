from flask import Blueprint, render_template
from models.leaderboard_model import get_top_users
from models.parcours_model import get_user_track_xp
from utils import calculer_rang, obtenir_titres_et_badges # Tout est regroupé ici !

leaderboard_bp = Blueprint('leaderboard', __name__)


@leaderboard_bp.route('/classement')
def classement():
    top_users = get_top_users(10)
    
    for index, user in enumerate(top_users):
        rang_info = calculer_rang(user['global_xp'], 'global')
        user['titre_rang'] = rang_info['titre']
        user['position'] = index + 1
        
        # On calcule l'XP de ce top joueur pour voir s'il a les badges
        py_xp = get_user_track_xp(user['id_utilisateur'], 1)
        js_xp = get_user_track_xp(user['id_utilisateur'], 2)
        sql_xp = get_user_track_xp(user['id_utilisateur'], 3)
        
        # On extrait juste ses badges débloqués
        user['badges_obtenus'] = [b for b in obtenir_titres_et_badges(user['global_xp'], py_xp, js_xp, sql_xp)['badges'] if b['debloque']]
        
    return render_template('leaderboard.html', top_users=top_users)