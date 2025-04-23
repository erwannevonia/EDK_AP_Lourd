import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  static const String baseUrl =
      'http://172.16.198.254:3000'; //Modifier l'adresse IP du serveur

  static Future<List<User>> getUser(
    String nom, String mdp
  ) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/user?nom=$nom&mdp=$mdp'
      ));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Impossible de récupérer l\'utilisateur.');
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
