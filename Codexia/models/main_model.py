from db import get_db_connection

def get_active_tracks():
    """Récupère tous les parcours actifs pour l'accueil."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM track WHERE is_active = 1")
    tracks = cursor.fetchall()
    cursor.close()
    conn.close()
    return tracks

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
    
    # On transforme ça en dictionnaire pour faciliter la recherche dans la Vue
    return {p['id_exercice']: p['status_progression'] for p in progressions}

def get_exercice_by_slug(chemin_url):
    """Récupère un exercice spécifique pour l'arène."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM exercice WHERE chemin_url = %s", (chemin_url,))
    exercice = cursor.fetchone()
    cursor.close()
    conn.close()
    return exercice

def get_exercice_for_validation(id_exercice):
    """Récupère les tests cachés et l'XP d'un exercice pour l'API de validation."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT test_code, xp_reward FROM exercice WHERE id_exercice = %s", (id_exercice,))
    exo = cursor.fetchone()
    cursor.close()
    conn.close()
    return exo

def enregistrer_soumission(id_utilisateur, id_exercice, code, db_status, test_output):
    """Sauvegarde la tentative de l'utilisateur dans l'historique (table soumission)."""
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
    
    # Vérifie s'il l'a déjà réussi
    cursor.execute("SELECT * FROM progresser WHERE id_utilisateur = %s AND id_exercice = %s AND status_progression = 'termine'", (id_utilisateur, id_exercice))
    deja_reussi = cursor.fetchone()
    
    if not deja_reussi:
        # 1. Valider dans progresser
        cursor.execute(
            "INSERT INTO progresser (id_utilisateur, id_exercice, status_progression, completed_at) VALUES (%s, %s, 'termine', NOW()) "
            "ON DUPLICATE KEY UPDATE status_progression = 'termine', completed_at = NOW()",
            (id_utilisateur, id_exercice)
        )
        # 2. Donner l'XP
        cursor.execute(
            "UPDATE utilisateur SET global_xp = global_xp + %s WHERE id_utilisateur = %s",
            (xp_reward, id_utilisateur)
        )
        conn.commit()
        
    cursor.close()
    conn.close()