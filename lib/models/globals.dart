class AppData {
  // Singleton - Instance unique
  static final AppData _instance = AppData._internal();

  // Constructor privé
  AppData._internal();

  // Getter pour accéder à l'instance
  static AppData get instance => _instance;

  // Variables pour stocker l'ID et le nom du compte
  int idCompte = 0;
  String nomCompte = '';

  // Fonction pour mettre à jour les données de l'utilisateur
  void updateUserData(int id, String nom) {
    idCompte = id;
    nomCompte = nom;
  }
  
  // Méthode pour convertir le JSON en AppData
  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData._internal()
      ..idCompte = json['Id_Compte'] is String
          ? int.tryParse(json['Id_Compte']) ?? 0
          : json['Id_Compte'] ?? 0
      ..nomCompte = json['Nom_Compte'] ?? '';
  }

  // Optionnel : Méthode pour afficher les données
  @override
  String toString() {
    return 'AppData(idCompte: $idCompte, nomCompte: $nomCompte)';
  }
}
