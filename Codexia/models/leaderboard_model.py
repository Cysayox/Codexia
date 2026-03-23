from db import get_db_connection

def get_top_users(limit=10):
    """Récupère les meilleurs joueurs (hors admins) triés par XP."""
    conn = get_db_connection()
    assert conn is not None
    cursor = conn.cursor(dictionary=True)
    
    # ⚠️ NOUVEAU : On exclut les admins et on limite à 10
    cursor.execute('''
        SELECT username, global_xp, avatar_url
        FROM utilisateur 
        WHERE role != 'admin'
        ORDER BY global_xp DESC 
        LIMIT %s
    ''', (limit,))
    
    top_users = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return top_users