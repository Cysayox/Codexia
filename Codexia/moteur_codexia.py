import subprocess
import tempfile
import os

def evaluer_code(code_utilisateur, code_test):
    """
    Prend le code de l'élève, le fusionne avec les tests du prof, 
    l'exécute de manière isolée et renvoie le résultat.
    """
    # 1. Fusionner le code (L'élève + Le correcteur caché)
    code_complet = code_utilisateur + "\n\n" + code_test

    # 2. Créer un fichier Python temporaire
    # (delete=False car subprocess a besoin de lire le fichier sur le disque)
    with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False, encoding='utf-8') as temp_file:
        temp_file.write(code_complet)
        temp_file_path = temp_file.name

    try:
        # 3. Exécuter le fichier avec subprocess
        # capture_output=True récupère le texte du terminal (stdout et stderr)
        # timeout=3 est VITAL : si le code tourne plus de 3 secondes, on le tue.
        resultat = subprocess.run(
            ['python', temp_file_path],
            capture_output=True,
            text=True,
            timeout=3
        )
        
        # 4. Analyser les résultats
        if resultat.returncode == 0:
            # returncode == 0 signifie que Python n'a rencontré aucune erreur
            return {"status": "success", "output": resultat.stdout.strip()}
        else:
            # Sinon, c'est qu'il y a eu une erreur (syntaxe, assert qui échoue, etc.)
            return {"status": "failed", "output": resultat.stderr.strip()}
            
    except subprocess.TimeoutExpired:
        # 5. Gestion de la boucle infinie de l'utilisateur
        return {"status": "failed", "output": "Erreur système : Temps d'exécution dépassé (Boucle infinie ou code trop lourd)."}
        
    finally:
        # 6. Nettoyage : On supprime le fichier temporaire pour ne pas saturer le disque
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)

# ==========================================
# --- SIMULATION DES CAS D'UTILISATION ---
# ==========================================
if __name__ == "__main__":
    print("--- TEST DU MOTEUR CODEXIA ---")
    
    # Le test secret de l'exercice (ce qui sera dans ta BDD)
    test_prof = "assert addition(2, 3) == 5, 'Erreur: 2+3 doit faire 5'\nprint('EXERCICE_REUSSI')"

    # CAS 1 : L'élève a tout bon
    print("\n🟢 CAS 1 : Code correct")
    code_bon = "def addition(a, b):\n    return a + b\n"
    print(evaluer_code(code_bon, test_prof))

    # CAS 2 : L'élève se trompe dans la logique
    print("\n🔴 CAS 2 : Code faux (Soustraction au lieu d'addition)")
    code_faux = "def addition(a, b):\n    return a - b\n"
    print(evaluer_code(code_faux, test_prof))

    # CAS 3 : L'élève fait planter le système (Boucle infinie)
    print("\n🔴 CAS 3 : L'élève écrit une boucle infinie")
    code_boucle = "def addition(a, b):\n    while True:\n        pass\n"
    print(evaluer_code(code_boucle, test_prof))