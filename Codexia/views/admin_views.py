from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from models.profil_model import get_user_by_id, delete_utilisateur
from models.parcours_model import get_exercice_by_slug
from models.admin_model import ajouter_exercice, modifier_exercice, get_all_users, update_user_by_admin
from utils import calculer_rang


admin_bp = Blueprint('admin', __name__)

# --- SÉCURITÉ : Vérifier si l'utilisateur est bien un Admin ---
def is_admin():
    if 'user_id' not in session: return False
    user = get_user_by_id(session['user_id'])
    return user and user['role'] == 'admin'

# --- ROUTE : Créer un exercice ---
@admin_bp.route('/admin/exercice/nouveau', methods=['GET', 'POST'])
def nouvel_exercice():
    if not is_admin():
        flash("Accès refusé. Vous n'êtes pas administrateur.", "error")
        return redirect(url_for('main.accueil'))
        
    if request.method == 'POST':
        # On récupère toutes les données du formulaire
        ajouter_exercice(request.form)
        flash("L'exercice a été ajouté avec succès !", "success")
        return redirect(url_for('main.accueil')) # Ou vers la page du parcours
        
    return render_template('admin_exercice.html', exercice=None)

# --- ROUTE : Modifier un exercice ---
@admin_bp.route('/admin/exercice/modifier/<slug>', methods=['GET', 'POST'])
def edit_exercice(slug):
    if not is_admin():
        flash("Accès refusé. Vous n'êtes pas administrateur.", "error")
        return redirect(url_for('main.accueil'))
        
    exercice = get_exercice_by_slug(slug)
    if not exercice:
        flash("Exercice introuvable.", "error")
        return redirect(url_for('main.accueil'))

    if request.method == 'POST':
        modifier_exercice(exercice['id_exercice'], request.form)
        flash("L'exercice a été modifié avec succès !", "success")
        return redirect(f"/parcours/{request.form['id_track']}") # Idéalement rediriger vers le slug du track
        
    return render_template('admin_exercice.html', exercice=exercice)

# --- ROUTE : Tableau de bord principal ---
@admin_bp.route('/admin')
def dashboard():
    if not is_admin():
        flash("Accès refusé. Vous n'êtes pas administrateur.", "error")
        return redirect(url_for('main.accueil'))
    
    # On récupère tous les utilisateurs
    utilisateurs = get_all_users()
    
    # On calcule le titre de chaque utilisateur pour l'affichage
    for u in utilisateurs:
        rang_info = calculer_rang(u['global_xp'], 'global')
        u['titre_rang'] = rang_info['titre']
        
    return render_template('admin.html', users=utilisateurs)

# --- ROUTE : Modifier un utilisateur ---
@admin_bp.route('/admin/utilisateur/modifier/<int:user_id>', methods=['GET', 'POST'])
def modifier_utilisateur(user_id):
    if not is_admin():
        flash("Accès refusé.", "error")
        return redirect(url_for('main.accueil'))
        
    user = get_user_by_id(user_id)
    if not user:
        flash("Utilisateur introuvable.", "error")
        return redirect(url_for('admin.dashboard'))
        
    if request.method == 'POST':
        username = request.form.get('username')
        email = request.form.get('email')
        global_xp = request.form.get('global_xp')
        
        update_user_by_admin(user_id, username, email, global_xp)
        flash(f"Le profil de {username} a été mis à jour.", "success")
        return redirect(url_for('admin.dashboard')) # On retourne au tableau de bord
        
    return render_template('admin_edit_user.html', user=user)

# --- ROUTE : Supprimer un utilisateur ---
@admin_bp.route('/admin/utilisateur/supprimer/<int:user_id>', methods=['POST'])
def supprimer_utilisateur(user_id):
    if not is_admin():
        flash("Accès refusé.", "error")
        return redirect(url_for('main.accueil'))
    
    user_to_delete = get_user_by_id(user_id)
    # Sécurité supplémentaire : on s'assure qu'on ne supprime pas un admin !
    if user_to_delete and user_to_delete['role'] != 'admin':
        delete_utilisateur(user_id)
        flash(f"L'utilisateur {user_to_delete['username']} a été banni définitivement.", "success")
    else:
        flash("Impossible de supprimer cet utilisateur.", "error")
        
    return redirect(url_for('admin.dashboard'))

# --- ROUTE : Simuler l'envoi d'un mail de réinitialisation ---
@admin_bp.route('/admin/utilisateur/reinitialiser-mdp/<int:user_id>', methods=['POST'])
def reinitialiser_mdp(user_id):
    if not is_admin():
        flash("Accès refusé.", "error")
        return redirect(url_for('main.accueil'))
        
    user = get_user_by_id(user_id)
    if not user:
        flash("Utilisateur introuvable.", "error")
        return redirect(url_for('admin.dashboard'))
        
    # --- SIMULATION DE L'ENVOI D'EMAIL ---
    # C'est ici qu'on mettrait la vraie logique d'envoi (avec Flask-Mail ou SendGrid par exemple)
    email_joueur = user['email']
    
    # On génère la notification de succès
    flash(f"Un email de réinitialisation a bien été envoyé à l'adresse : {email_joueur}", "success")
    
    # On recharge la page d'édition de l'utilisateur
    return redirect(url_for('admin.modifier_utilisateur', user_id=user_id))