import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  static const String baseUrl =
      'http://172.16.198.254:3000'; //Modifier l'adresse IP du serveur

  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/user'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Impossible de récupérer les utilisateurs.');
    }
  }
}
