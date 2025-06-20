class User {
  final int id;
  final String nom;
  final String mdp;
  final String mail;
  final int idClasse;
  final bool a2f;

  User({
    required this.id,
    required this.nom,
    required this.mdp,
    required this.mail,
    required this.idClasse,
    required this.a2f,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['Id_Compte'],
      nom: json['Nom_Compte'],
      mdp: json['Mdp_Compte'],
      mail: json['Mail_Compte'],
      idClasse: json['Id_Classe'],
      a2f: json['A2F'],
    );
  }
}
