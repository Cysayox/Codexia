from flask import Blueprint, render_template
from models.leaderboard_model import get_top_users
from utils import calculer_rang

leaderboard_bp = Blueprint('leaderboard', __name__)

@leaderboard_bp.route('/classement')
def classement():
    # ⚠️ NOUVEAU : On demande le Top 10
    top_users = get_top_users(10)
    
    for index, user in enumerate(top_users):
        rang_info = calculer_rang(user['global_xp'])
        user['titre_rang'] = rang_info['titre']
        user['position'] = index + 1
        
    return render_template('leaderboard.html', top_users=top_users)