import mysql.connector
from db import get_db_connection

def get_user_by_id(user_id):
    """Récupère toutes les infos d'un utilisateur grâce à son ID."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM utilisateur WHERE id_utilisateur = %s", (user_id,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    return user

def get_historique_user(user_id):
    """Récupère l'historique des exercices terminés par l'utilisateur."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = """
        SELECT e.title, e.chemin_url, e.xp_reward, p.completed_at
        FROM progresser p
        JOIN exercice e ON p.id_exercice = e.id_exercice
        WHERE p.id_utilisateur = %s AND p.status_progression = 'termine'
        ORDER BY p.completed_at DESC
    """
    cursor.execute(query, (user_id,))
    historique = cursor.fetchall()
    cursor.close()
    conn.close()
    return historique

def update_profil_base(user_id, username, email):
    """Met à jour le pseudo et l'email (Gère les doublons)."""
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute('''
            UPDATE utilisateur 
            SET username = %s, email = %s 
            WHERE id_utilisateur = %s
        ''', (username, email, user_id))
        conn.commit()
        return True, "Profil mis à jour avec succès !"
    except mysql.connector.IntegrityError:
        return False, "Ce pseudo ou cet e-mail est déjà utilisé."
    finally:
        cursor.close()
        conn.close()

def update_password(user_id, new_hash):
    """Met à jour le mot de passe."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('UPDATE utilisateur SET password_hash = %s WHERE id_utilisateur = %s', (new_hash, user_id))
    conn.commit()
    cursor.close()
    conn.close()

def update_avatar(user_id, avatar_url):
    """Met à jour l'image de profil."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('UPDATE utilisateur SET avatar_url = %s WHERE id_utilisateur = %s', (avatar_url, user_id))
    conn.commit()
    cursor.close()
    conn.close()

def delete_utilisateur(user_id):
    """Supprime l'utilisateur (et ses données en cascade)."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('DELETE FROM utilisateur WHERE id_utilisateur = %s', (user_id,))
    conn.commit()
    cursor.close()
    conn.close()

def get_user_stats_by_track(user_id):
    """Récupère l'XP accumulée pour CHAQUE parcours actif."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # NOUVELLE REQUÊTE CORRIGÉE
    cursor.execute('''
        SELECT t.name as track_name, COALESCE(user_xp.total_xp, 0) as xp
        FROM track t
        LEFT JOIN (
            SELECT e.id_track, SUM(e.xp_reward) as total_xp
            FROM progresser p
            JOIN exercice e ON p.id_exercice = e.id_exercice
            WHERE p.id_utilisateur = %s AND p.status_progression = 'termine'
            GROUP BY e.id_track
        ) user_xp ON t.id_track = user_xp.id_track
        WHERE t.is_active = 1
    ''', (user_id,))
    
    stats = cursor.fetchall()
    cursor.close()
    conn.close()
    return stats
