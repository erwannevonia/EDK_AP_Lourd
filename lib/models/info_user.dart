class InfoUser {
  final int id;
  final String nom;
  final String mail;
  final int idClasse;
  final int a2f;

  InfoUser({
    required this.id,
    required this.nom,
    required this.mail,
    required this.idClasse,
    required this.a2f,
  });

  factory InfoUser.fromJson(Map<String, dynamic> json) {
    return InfoUser(
      id: json['Id_Compte'],
      nom: json['Nom_Compte'],
      mail: json['Mail_Compte'],
      idClasse: json['Id_Classe'],
      a2f: json['A2F'],
    );
  }
}