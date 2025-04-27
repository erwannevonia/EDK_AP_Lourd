import 'package:flutter/material.dart';
import '../models/globals.dart';

class DevoirScreen extends StatelessWidget {
  const DevoirScreen({super.key});




  void _afficherPopup(BuildContext context) {
    int idCompte = AppData.instance.idCompte;
    String nomCompte = AppData.instance.nomCompte;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Titre de la pop-up"),
          content: Text('ID du compte : $idCompte, Nom du compte : $nomCompte'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Fermer la pop-up
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Mon Profil', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Hello :D"),
          ElevatedButton(
            // ignore: avoid_print
            onPressed: () => _afficherPopup(context),
            child: const Text("Une question ?"),
          ),
        ],
      )),
    );
  }
}
