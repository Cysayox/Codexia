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
def calculer_rang(xp):
    """Retourne le rang (texte) et le niveau numérique (1 à 5) selon l'XP."""
    if xp >= 4200: return {"titre": "Maître", "niveau": 5}
    if xp >= 2900: return {"titre": "Expert", "niveau": 4}
    if xp >= 2200: return {"titre": "Avancé", "niveau": 3}
    if xp >= 1300: return {"titre": "Intermédiaire", "niveau": 2}
    return {"titre": "Débutant", "niveau": 1}

def niveau_requis(grade_texte):
    """Convertit le texte du grade de l'exercice en niveau numérique pour comparer."""
    niveaux = {"Débutant": 1, "Intermédiaire": 2, "Avancé": 3, "Expert": 4, "Maître": 5}
    return niveaux.get(grade_texte, 1)