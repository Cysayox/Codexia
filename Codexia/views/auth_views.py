from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from models.auth_model import creer_utilisateur, verifier_utilisateur

# On crée notre "Blueprint" (notre mini-application)
auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/inscription', methods=['GET', 'POST'])
def inscription():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        
        succes, message = creer_utilisateur(username, email, password)
        
        if succes:
            flash(message, "success")
            # ⚠️ Redirection vers la route connexion du blueprint auth
            return redirect(url_for('auth.connexion')) 
        else:
            flash(message, "error")
            
    return render_template('register.html')

@auth_bp.route('/connexion', methods=['GET', 'POST'])
def connexion():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        
        succes, user = verifier_utilisateur(email, password)
        
        if succes:
            session['user_id'] = user['id_utilisateur']
            session['username'] = user['username']
            session['xp'] = user['global_xp']
            session['avatar_url'] = user['avatar_url']
            
            # ⚠️ Redirection vers la route accueil du blueprint main
            return redirect(url_for('main.accueil')) 
        else:
            flash("Email ou mot de passe incorrect.", "error")
            
    return render_template('login.html')

@auth_bp.route('/deconnexion')
def deconnexion():
    session.clear()
    # ⚠️ Redirection vers la route accueil du blueprint main
    return redirect(url_for('main.accueil'))