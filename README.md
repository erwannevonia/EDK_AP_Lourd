# 📘 EDK_AP_Lourd

Application lourde développée dans le cadre du BTS SIO (option SLAM), basée sur la base de données EDK.  
Elle permet de gérer et d'afficher les informations liées aux utilisateurs, principalement les professeurs.

## 🛠️ Technologies utilisées

- **Langage** : Dart
- **Framework** : Flutter (version desktop)
- **Base de données** : MySQL/MariaDB (EDK)
- **Backend** : API Node.js (projet associé)
- **Architecture** : MVC simplifié

## 📦 Fonctionnalités

- 🔍 Affichage des **élèves** sous forme de **cards dynamiques**
- 📂 Connexion à une **base de données complexe** avec plusieurs tables (`PROFESSEUR`, `COMPTE`, `CLASSE`, etc.)
- 🖱️ Interactions utilisateur :
  - Chaque card d'élève peut être **cliquée** pour afficher plus d'informations
  - Des **actions** sont prévues à l’ouverture de la card (modification, suppression, etc.)
- 🔄 Connexion à une **API Node.js** pour récupérer les données via requêtes HTTP

## 📁 Structure du projet

```bash
/lib
├── models/
│   └── info_user.dart              # Modèle représentant un élève
├── screens/
│   └── eleves_screen.dart          # Page principale avec les cards
│   └── settings_screen.dart        # Page secondaire avec les paramètres
├── services/
│   └── api_service.dart            # Gestion des appels à l’API
├── eleve_details_page.dart         # Page de détails des élèves une fois cliquée
├── main.dart                       # Point d’entrée de l’application
├── navbar.dart                     # Page gérant la navbar et les deux vues dans le dossier screens
```

## ⚙️ Configuration

### Prérequis

* Flutter installé (channel stable recommandé)
* API Node.js opérationnelle (voir [dépôt associé](https://github.com/erwannevonia/EDK_API))
* Base de données MySQL importée avec les données EDK

### Installation

```bash
git clone https://github.com/erwannevonia/EDK_AP_Lourd.git
cd EDK_AP_Lourd
flutter pub get
flutter run
```

> Penser à lancer l'API sur la VM aussi, pour que la communication avec la base de données marche

## 📜 Licence

Ce projet est réalisé dans un cadre **pédagogique**.
Usage libre à des fins d'apprentissage.

---

