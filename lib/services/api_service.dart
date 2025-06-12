import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/info_user.dart';
import '../models/globals.dart';

class ApiService {
  static const String baseUrl =
      'http://localhost:3000'; //Modifier l'adresse IP du serveur

  static Future<List<AppData>> getUser(
    String nom, String mdp
  ) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/user?nom=$nom&mdp=$mdp'
      ));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => AppData.fromJson(user)).toList();
    } else {
      throw Exception('Impossible de récupérer l\'utilisateur.');
    }
  }

  static Future<List<InfoUser>> fetchEleves(
  ) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/eleves'
      ));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => InfoUser.fromJson(json)).toList();
    } else {
      throw Exception('Échec du chargement des élèves');
    }
  }

  static Future<String> deleteEleve(
    int id
  ) async {
    final response = await http.delete(Uri.parse('$baseUrl/utilisateurs/$id'));

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        return data['message'] ?? 'Compte supprimé';
      } catch (e) {
        return 'Compte supprimé (pas de message JSON)';
      }
    } else {
      try {
        final data = json.decode(response.body);
        throw Exception(data['error'] ?? 'Erreur inconnue');
      } catch (e) {
        throw Exception('Erreur inconnue (réponse non JSON)');
      }
    }
  }

  static Future<String> updateMotDePasse(
    int id, String nouveauMdp
  ) async {
  final response = await http.put(
    Uri.parse('$baseUrl/utilisateurs/$id/mdp'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'mdp': nouveauMdp}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['message'] ?? 'Mot de passe mis à jour';
  } else {
    try {
      final error = json.decode(response.body)['error'];
      throw Exception(error ?? 'Erreur inconnue');
    } catch (e) {
      throw Exception('Erreur inconnue (réponse invalide)');
    }
  }
}

  // Future<List<Concert>> searchConcerts(
  //     String scene, String date, String artiste) async {
  //   final response = await http.get(Uri.parse(
  //     '$baseUrl/concerts?scene=$scene&date=$date&artiste=$artiste',
  //   ));

  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((concert) => Concert.fromJson(concert)).toList();
  //   } else {
  //     throw Exception('Failed to load concerts');
  //   }
  // }
}
