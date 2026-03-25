from db import get_db_connection

def get_track_by_slug(slug):
    """Récupère un parcours selon son URL."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id_track, name FROM track WHERE chemin_url = %s", (slug,))
    track = cursor.fetchone()
    cursor.close()
    conn.close()
    return track

def get_exercices_by_track(track_id):
    """Récupère tous les exercices d'un parcours, triés par ordre."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT id_exercice, title, description, grade_exercice, xp_reward, theme_chapitre, chemin_url 
        FROM exercice WHERE id_track = %s ORDER BY numero_ordre ASC
    ''', (track_id,))
    exercices = cursor.fetchall()
    cursor.close()
    conn.close()
    return exercices

def get_user_progress(user_id):
    """Récupère la progression (en cours/terminé) d'un utilisateur."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id_exercice, status_progression FROM progresser WHERE id_utilisateur = %s", (user_id,))
    progressions = cursor.fetchall()
    cursor.close()
    conn.close()
    return {p['id_exercice']: p['status_progression'] for p in progressions}

# ⚠️ LA FONCTION QUI MANQUAIT EST ICI ⚠️
def get_exercice_by_slug(slug):
    """Récupère toutes les infos d'un exercice, son parcours, et sa correction s'il y en a une."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT e.*, t.chemin_url AS track_slug, c.code_solution, c.explication
        FROM exercice e 
        JOIN track t ON e.id_track = t.id_track 
        LEFT JOIN correction c ON e.id_exercice = c.id_exercice
        WHERE e.chemin_url = %s
    """, (slug,))
    exercice = cursor.fetchone()
    cursor.close()
    conn.close()
    return exercice

def get_exercice_for_validation(id_exercice):
    """Récupère le test caché, l'XP et l'ID du parcours de l'exercice pour la validation."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # id_track est bien présent ici !
    cursor.execute("SELECT id_track, test_code, xp_reward FROM exercice WHERE id_exercice = %s", (id_exercice,))
    
    exo = cursor.fetchone()
    cursor.close()
    conn.close()
    return exo

def enregistrer_soumission(id_utilisateur, id_exercice, code, db_status, test_output):
    """Sauvegarde la tentative de l'utilisateur dans l'historique."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO soumission (id_utilisateur, id_exercice, code, status_soumission, test_output) VALUES (%s, %s, %s, %s, %s)",
        (id_utilisateur, id_exercice, code, db_status, test_output[:1000])
    )
    conn.commit()
    cursor.close()
    conn.close()

def valider_exercice_et_donner_xp(id_utilisateur, id_exercice, xp_reward):
    """Si l'exercice est réussi pour la 1ère fois, on met à jour la progression et l'XP."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    cursor.execute("SELECT * FROM progresser WHERE id_utilisateur = %s AND id_exercice = %s AND status_progression = 'termine'", (id_utilisateur, id_exercice))
    deja_reussi = cursor.fetchone()
    
    if not deja_reussi:
        cursor.execute(
            "INSERT INTO progresser (id_utilisateur, id_exercice, status_progression, completed_at) VALUES (%s, %s, 'termine', NOW()) "
            "ON DUPLICATE KEY UPDATE status_progression = 'termine', completed_at = NOW()",
            (id_utilisateur, id_exercice)
        )
        cursor.execute(
            "UPDATE utilisateur SET global_xp = global_xp + %s WHERE id_utilisateur = %s",
            (xp_reward, id_utilisateur)
        )
        conn.commit()
        
    cursor.close()
    conn.close()

def get_user_track_xp(user_id, track_id):
    """Calcule l'XP d'un utilisateur pour un parcours spécifique."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT COALESCE(SUM(e.xp_reward), 0) as track_xp
        FROM progresser p
        JOIN exercice e ON p.id_exercice = e.id_exercice
        WHERE p.id_utilisateur = %s AND e.id_track = %s AND p.status_progression = 'termine'
    ''', (user_id, track_id))
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return int(result['track_xp'])

def get_next_exercice(id_track, numero_ordre):
    """Récupère l'exercice suivant dans le même parcours."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT chemin_url FROM exercice 
        WHERE id_track = %s AND numero_ordre = %s
    """, (id_track, numero_ordre + 1))
    next_exo = cursor.fetchone()
    cursor.close()
    conn.close()
    return next_exo