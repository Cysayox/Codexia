from db import get_db_connection

def ajouter_exercice(data):
    """Ajoute un nouvel exercice ET sa correction en BDD."""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # 1. On insère l'exercice principal
    cursor.execute('''
        INSERT INTO exercice (title, description, instructions, grade_exercice, xp_reward, 
                              theme_chapitre, chemin_url, base_code, test_code, id_track, numero_ordre)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ''', (
        data['title'], data['description'], data['instructions'], data['grade_exercice'],
        data['xp_reward'], data['theme_chapitre'], data['chemin_url'], data['base_code'],
        data['test_code'], data['id_track'], data['numero_ordre']
    ))
    
    # On récupère l'ID de l'exercice qu'on vient tout juste de créer
    id_nouvel_exo = cursor.lastrowid
    
    # 2. On insère la correction dans la 2ème table (si l'admin a rempli les champs)
    if data.get('code_solution') or data.get('explication'):
        cursor.execute('''
            INSERT INTO correction (id_exercice, code_solution, explication)
            VALUES (%s, %s, %s)
        ''', (id_nouvel_exo, data.get('code_solution'), data.get('explication')))
        
    conn.commit()
    cursor.close()
    conn.close()

def modifier_exercice(id_exercice, data):
    """Met à jour un exercice existant ET sa correction."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True) # On passe en mode dictionary pour le SELECT
    
    # 1. On met à jour l'exercice principal
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
    
    # 2. Gestion de la correction (Update ou Insert)
    if data.get('code_solution') or data.get('explication'):
        # On vérifie si l'exercice avait DÉJÀ une correction existante
        cursor.execute('SELECT id_correction FROM correction WHERE id_exercice=%s', (id_exercice,))
        correction_existante = cursor.fetchone()
        
        if correction_existante:
            # S'il en avait une, on la met à jour
            cursor.execute('''
                UPDATE correction 
                SET code_solution=%s, explication=%s 
                WHERE id_exercice=%s
            ''', (data.get('code_solution'), data.get('explication'), id_exercice))
        else:
            # S'il n'en avait pas encore, on la crée
            cursor.execute('''
                INSERT INTO correction (id_exercice, code_solution, explication) 
                VALUES (%s, %s, %s)
            ''', (id_exercice, data.get('code_solution'), data.get('explication')))
            
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