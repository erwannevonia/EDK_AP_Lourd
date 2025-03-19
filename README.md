# EDK

## Description
**EDK Lourd** est la version administrative de l'application d'agenda légère EDK. Cette version permet aux administrateurs de gérer les paramètres généraux de l'application ainsi que d'effectuer des actions de maintenance et de configuration.

L'application légère est accessible à l'adresse suivante : `http://172.16.198.254`

## Fonctionnalités
- Gestion des utilisateurs et des permissions
- Paramétrage global de l'application
- Consultation et modification des événements
- Intégration avec l'application légère
- Système de logs et suivi des actions

## Installation
1. Clonez le dépôt :
   ```sh
   git clone https://github.com/votre-utilisateur/votre-repo.git
   ```
2. Accédez au dossier du projet :
   ```sh
   cd votre-repo
   ```
3. Installez les dépendances :
   ```sh
   flutter pub get
   ```
4. Lancez l'application :
   ```sh
   flutter run
   ```

## Configuration
Un fichier de configuration `.env` peut être requis pour personnaliser l'application. Exemple de configuration :
```env
API_URL=https://api.exemple.com
DB_NAME=agenda_admin
DB_USER=admin
DB_PASS=motdepasse
```

## Contribution
Les contributions sont les bienvenues ! Merci de soumettre une issue ou une pull request avec vos améliorations.

## Licence
Ce projet est sous licence [Nom de la Licence] - voir le fichier LICENSE pour plus de détails.

