import os
from werkzeug.utils import secure_filename

# ==========================================
# CONFIGURATION DES FICHIERS (Avatars)
# ==========================================
UPLOAD_FOLDER = 'static/uploads/avatars'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    """Vérifie si l'extension du fichier est autorisée."""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# ==========================================
# LOGIQUE DE GAMIFICATION
# ==========================================
def calculer_rang(xp, track_name='global'):
    """Retourne le rang et le niveau selon l'XP et le langage évalué."""
    track_lower = track_name.lower()
    
    # 1. BARÈME PYTHON (Max 5000 XP)
    if track_lower == 'python':
        if xp >= 4200: return {"titre": "Maître", "niveau": 5}
        if xp >= 2900: return {"titre": "Expert", "niveau": 4}
        if xp >= 2200: return {"titre": "Avancé", "niveau": 3}
        if xp >= 1300: return {"titre": "Intermédiaire", "niveau": 2}
        return {"titre": "Débutant", "niveau": 1}
        
    # 2. BARÈME JS ET SQL (Max 8150 XP)
    elif track_lower in ['javascript', 'sql']:
        if xp >= 5650: return {"titre": "Maître", "niveau": 5}
        if xp >= 4800: return {"titre": "Expert", "niveau": 4}
        if xp >= 2500: return {"titre": "Avancé", "niveau": 3}
        if xp >= 1300: return {"titre": "Intermédiaire", "niveau": 2}
        return {"titre": "Débutant", "niveau": 1}
        
    # 3. LES 10 TITRES GLOBAUX (Max 21300 XP)
    else:
        if xp >= 21300: return {"titre": "Légende de Codexia", "niveau": 10}
        if xp >= 19000: return {"titre": "Grand Sorcier du Code", "niveau": 9}
        if xp >= 16000: return {"titre": "Maître des Données", "niveau": 8}
        if xp >= 12000: return {"titre": "Architecte Numérique", "niveau": 7}
        if xp >= 8000:  return {"titre": "Artisan Logiciel", "niveau": 6}
        if xp >= 5000:  return {"titre": "Développeur Confirmé", "niveau": 5}
        if xp >= 3000:  return {"titre": "Forgeron du Code", "niveau": 4}
        if xp >= 1500:  return {"titre": "Initié des Algorithmes", "niveau": 3}
        if xp >= 500:   return {"titre": "Apprenti Codeur", "niveau": 2}
        return {"titre": "Novice de l'Arène", "niveau": 1}
    
def niveau_requis(grade_texte):
    """Convertit le texte du grade de l'exercice en niveau numérique pour comparer."""
    niveaux = {"Débutant": 1, "Intermédiaire": 2, "Avancé": 3, "Expert": 4, "Maître": 5}
    return niveaux.get(grade_texte, 1)

def obtenir_titres_et_badges(global_xp, python_xp, js_xp, sql_xp):
    """Génère la liste des 10 titres globaux et des 3 badges de parcours."""
    
    # Génération dynamique des 10 titres globaux
    paliers = [0, 500, 1500, 3000, 5000, 8000, 12000, 16000, 19000, 21300]
    noms_titres = [
        "Novice de l'Arène", "Apprenti Codeur", "Initié des Algorithmes", 
        "Forgeron du Code", "Développeur Confirmé", "Artisan Logiciel", 
        "Architecte Numérique", "Maître des Données", "Grand Sorcier du Code", "Légende de Codexia"
    ]
    
    titres_globaux = []
    for i in range(10):
        titres_globaux.append({
            "nom": noms_titres[i],
            "debloque": global_xp >= paliers[i],
            "requis": paliers[i]
        })

    # Génération des 3 badges de maîtrise
    badges_maitrise = [
        {
            "nom": "Maître en Python",
            "icone": "python.svg",
            "couleur": "#10a37f", # Vert
            "debloque": python_xp >= 4200
        },
        {
            "nom": "Maître en JavaScript",
            "icone": "javascript.svg",
            "couleur": "#f1c40f", # Jaune
            "debloque": js_xp >= 5650
        },
        {
            "nom": "Maître en SQL",
            "icone": "sql.svg",
            "couleur": "#f39c12", # Orange
            "debloque": sql_xp >= 5650
        }
    ]
    
    return {"titres": titres_globaux, "badges": badges_maitrise}