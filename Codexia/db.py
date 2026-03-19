import mysql.connector
from mysql.connector import Error

def get_db_connection():
    """Crée et retourne une connexion à la base de données WAMP."""
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='codexia',  # Le nom de ta base de données
            user='root',         # L'utilisateur par défaut de WAMP
            password=''          # Pas de mot de passe par défaut sur WAMP
        )
        return connection
    except Error as e:
        print(f"❌ Erreur de connexion à MySQL: {e}")
        return None