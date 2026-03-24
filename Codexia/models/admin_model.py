from db import get_db_connection

def ajouter_exercice(data):
    """Ajoute un nouvel exercice en BDD."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO exercice (title, description, instructions, grade_exercice, xp_reward, 
                              theme_chapitre, chemin_url, base_code, test_code, id_track, numero_ordre)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ''', (
        data['title'], data['description'], data['instructions'], data['grade_exercice'],
        data['xp_reward'], data['theme_chapitre'], data['chemin_url'], data['base_code'],
        data['test_code'], data['id_track'], data['numero_ordre']
    ))
    conn.commit()
    cursor.close()
    conn.close()

def modifier_exercice(id_exercice, data):
    """Met à jour un exercice existant."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        UPDATE exercice 
        SET title=%s, description=%s, instructions=%s, grade_exercice=%s, xp_reward=%s, 
            theme_chapitre=%s, chemin_url=%s, base_code=%s, test_code=%s, id_track=%s, numero_ordre=%s
        WHERE id_exercice=%s
    ''', (
        data['title'], data['description'], data['instructions'], data['grade_exercice'],
        data['xp_reward'], data['theme_chapitre'], data['chemin_url'], data['base_code'],
        data['test_code'], data['id_track'], data['numero_ordre'], id_exercice
    ))
    conn.commit()
    cursor.close()
    conn.close()

def get_all_users():
    """Récupère tous les utilisateurs (hors admins) pour le panel admin."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # ⚠️ NOUVEAUTÉ : Ajout du WHERE role != 'admin'
    cursor.execute('''
        SELECT id_utilisateur, username, email, global_xp, role, created_at 
        FROM utilisateur 
        WHERE role != 'admin'
        ORDER BY created_at DESC
    ''')
    
    users = cursor.fetchall()
    cursor.close()
    conn.close()
    return users

def update_user_by_admin(user_id, username, email, global_xp):
    """Met à jour le profil d'un joueur depuis le panel admin."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        UPDATE utilisateur 
        SET username = %s, email = %s, global_xp = %s
        WHERE id_utilisateur = %s
    ''', (username, email, global_xp, user_id))
    conn.commit()
    cursor.close()
    conn.close()