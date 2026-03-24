from flask import Flask, session # ⚠️ N'oublie pas d'ajouter session ici !
from views.auth_views import auth_bp
from views.profil_views import profil_bp
from views.main_views import main_bp
from views.parcours_views import parcours_bp 
from views.leaderboard_views import leaderboard_bp
from views.admin_views import admin_bp
from models.profil_model import get_user_by_id

app = Flask(__name__)

app.secret_key = 'une_cle_secrete_tres_complexe_pour_codexia'
app.config['UPLOAD_FOLDER'] = 'static/uploads/avatars'

# Enregistrement de tous les modules
app.register_blueprint(auth_bp)
app.register_blueprint(profil_bp)
app.register_blueprint(main_bp)
app.register_blueprint(parcours_bp)
app.register_blueprint(leaderboard_bp)
app.register_blueprint(admin_bp)

# --- INJECTION GLOBALE DE L'UTILISATEUR ---
@app.context_processor
def inject_current_user():
    current_user = None
    if 'user_id' in session:
        current_user = get_user_by_id(session['user_id'])
    return dict(current_user=current_user)

if __name__ == '__main__':
    app.run(debug=True)