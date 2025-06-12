// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '/services/api_service.dart';
import '/models/globals.dart';
import 'navbar.dart';
import 'models/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'EDK Admin',
      themeMode: themeProvider.themeMode, 
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title:
              Text('Mon Profil', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Center(
          child: Column(children: [
            TextField(
              controller: nomController,
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                labelStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
            TextField(
              controller: mdpController,
              obscureText: true,
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface),
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
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
              child: const Text("Se connecter"),
              )
          ]),
        ));
  }
}
