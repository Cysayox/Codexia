<?php
// 1. Simulation : Ce que tape l'utilisateur (Normalement issu du front-end)
$code_utilisateur = "def addition(a, b):\n    return a + b\n";

// 2. Simulation : Le test secret du professeur (Normalement issu de ta BDD)
// On utilise 'assert' en Python. Si c'est faux, ça crashe. Si c'est vrai, ça continue.
$code_test = "\nassert addition(2, 3) == 5, 'Erreur: 2+3 doit faire 5'\nprint('EXERCICE_REUSSI')";

// 3. On fusionne les deux
$code_final = $code_utilisateur . $code_test;

// 4. On prépare le paquet (Payload) pour l'API Piston
$donnees_api = [
    "language" => "python",
    "version" => "3.10", // La version de Python prise en charge par Piston
    "files" => [
        [
            "content" => $code_final
        ]
    ]
];

// 5. On configure cURL pour envoyer la requête HTTP POST
$url = 'https://emkc.org/api/v2/piston/execute';
$ch = curl_init($url);

curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // On veut récupérer la réponse
curl_setopt($ch, CURLOPT_POST, true); // C'est une requête d'envoi
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']); // On précise qu'on envoie du JSON
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($donnees_api)); // On transforme notre tableau PHP en JSON

// 6. On exécute la requête et on ferme cURL
$reponse_brute = curl_exec($ch);
curl_close($ch);

// 7. On décode la réponse JSON renvoyée par Piston
$resultat = json_decode($reponse_brute, true);

// 8. Analyse du résultat
echo "--- ANALYSE DE L'EXECUTION ---\n\n";

if (!empty($resultat['run']['stderr'])) {
    // S'il y a quelque chose dans 'stderr' (Standard Error), c'est que le code a planté
    echo "❌ ÉCHEC :\n";
    echo $resultat['run']['stderr'];
} else {
    // Sinon, on regarde ce qui s'est affiché dans la console 'stdout' (Standard Output)
    $sortie = trim($resultat['run']['stdout']);
    if ($sortie === 'EXERCICE_REUSSI') {
         echo "✅ SUCCÈS : L'exercice est validé !";
    } else {
         echo "⚠️ Résultat inattendu : " . $sortie;
    }
}
?>