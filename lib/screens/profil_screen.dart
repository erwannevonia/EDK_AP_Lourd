// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../services/api_service.dart';
import '../models/globals.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  final TextEditingController nomController = TextEditingController();
  final TextEditingController mdpController = TextEditingController();

  String _convertToSHA256(input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _verifConnexion(String nom, String mdp) async {
    print('Nom = $nom');
    print('mdp = $mdp');
    
    List<AppData> userDataList = await ApiService.getUser(nom, mdp);
  
    if (userDataList.isNotEmpty) {
      AppData userData = userDataList.first; // Prendre le premier utilisateur
      AppData.instance.updateUserData(userData.idCompte, userData.nomCompte); // Mettre à jour le singleton
  
      print('Utilisateur connecté: ${AppData.instance.nomCompte}, ID: ${AppData.instance.idCompte}');
    } else {
      print("Erreur : aucune donnée utilisateur reçue");
    }
  }

  
  

  // void _searchConcerts() {
  //   setState(() {
  //     _concerts = ApiService.fuiteConcerts(
  //       artiste: artisteController.text.trim(),
  //       scene: sceneController.text.trim(),
  //       date: formattedDate,
  //     );
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title:
              const Text('Mon Profil', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
        body: Center(
          child: Column(children: [
            TextField(
              controller: nomController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Nom d\'utilisateur',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            TextField(
              controller: mdpController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String input = mdpController.text;
                String mdp = _convertToSHA256(input);
                String nom = nomController.text;
                _verifConnexion(nom, mdp);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text("Se connecter"),
              )
          ]),
        ));
  }
}
