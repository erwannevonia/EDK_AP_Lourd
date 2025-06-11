// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../services/api_service.dart';
import '../models/globals.dart';
import 'navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDK Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EDK Admin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController mdpController = TextEditingController();

  String _convertToSHA256(input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _verifConnexion(String nom, String mdp, context) async {
    print('Nom = $nom');
    print('mdp = $mdp');
    
    List<AppData> userDataList = await ApiService.getUser(nom, mdp);
  
    if (userDataList.isNotEmpty) {
      AppData userData = userDataList.first; // Prendre le premier utilisateur
      AppData.instance.updateUserData(userData.idCompte, userData.nomCompte); // Mettre à jour le singleton
  
      print('Utilisateur connecté: ${AppData.instance.nomCompte}, ID: ${AppData.instance.idCompte}');

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ConnectedPage(title: 'Navbar',)));
    } else {
      print("Erreur : aucune donnée utilisateur reçue");
    }
  }

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
                _verifConnexion(nom, mdp, context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text("Se connecter"),
              )
          ]),
        ));
  }
}
