import mysql.connector
from db import get_db_connection
from werkzeug.security import generate_password_hash, check_password_hash

def creer_utilisateur(username, email, password):
    """Enregistre un nouvel utilisateur en base de données."""
    hashed_password = generate_password_hash(password)
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        cursor.execute(
            "INSERT INTO utilisateur (username, email, password_hash, global_level, global_xp) VALUES (%s, %s, %s, 1, 0)",
            (username, email, hashed_password)
        )
        conn.commit()
        return True, "Compte créé avec succès ! Tu peux te connecter."
    except mysql.connector.IntegrityError:
        return False, "Erreur : Ce pseudo ou cet email existe déjà."
    finally:
        cursor.close()
        conn.close()

def verifier_utilisateur(email, password_candidate):
    """Vérifie l'email et le mot de passe pour la connexion."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM utilisateur WHERE email = %s", (email,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    
    if user and check_password_hash(user['password_hash'], password_candidate):
        return True, user
    return False, None