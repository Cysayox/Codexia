import subprocess
import tempfile
import os

def evaluer_code(code_utilisateur, code_test, langage='python'):
    """
    Prend le code de l'élève, le fusionne avec les tests du prof, 
    l'exécute de manière isolée selon le langage et renvoie le résultat.
    """
    # 1. Fusionner le code
    code_complet = code_utilisateur + "\n\n" + code_test

    # 2. Déterminer l'extension du fichier selon le langage
    extension = '.js' if langage == 'javascript' else '.py'

    # 3. Créer un fichier temporaire
    with tempfile.NamedTemporaryFile(mode='w', suffix=extension, delete=False, encoding='utf-8') as temp_file:
        temp_file.write(code_complet)
        temp_file_path = temp_file.name

    try:
        # 4. Choisir l'exécutable système (python ou node)
        commande = ['node', temp_file_path] if langage == 'javascript' else ['python', temp_file_path]

        # 5. Exécuter le fichier avec subprocess
        resultat = subprocess.run(
            commande,
            capture_output=True,
            text=True,
            timeout=3
        )
        
        # 6. Analyser les résultats
        if resultat.returncode == 0:
            return {"status": "success", "output": resultat.stdout.strip()}
        else:
            # En JS, l'erreur d'assert est souvent un peu longue, on la nettoie si besoin
            erreur = resultat.stderr.strip()
            return {"status": "failed", "output": erreur}
            
    except subprocess.TimeoutExpired:
        return {"status": "failed", "output": "Erreur système : Temps d'exécution dépassé (Boucle infinie ou code trop lourd)."}
        
    finally:
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)

# ==========================================
# --- SIMULATION DES CAS D'UTILISATION ---
# ==========================================
if __name__ == "__main__":
    print("--- TEST DU MOTEUR MULTILINGUE ---")
    
    # TEST PYTHON
    print("\n🟢 TEST PYTHON :")
    test_py = "assert addition(2, 3) == 5\nprint('EXERCICE_REUSSI')"
    code_py = "def addition(a, b):\n    return a + b\n"
    print(evaluer_code(code_py, test_py, langage='python'))

    # TEST JAVASCRIPT
    print("\n🟡 TEST JAVASCRIPT :")
    test_js = "const assert = require('assert');\nassert.strictEqual(addition(2, 3), 5);\nconsole.log('EXERCICE_REUSSI');"
    code_js = "function addition(a, b) {\n    return a + b;\n}\n"
    print(evaluer_code(code_js, test_js, langage='javascript'))