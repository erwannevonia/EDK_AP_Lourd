import 'package:flutter/material.dart';

class DevoirScreen extends StatelessWidget {
  const DevoirScreen({super.key});

  void _afficherPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Titre de la pop-up"),
          content: const Text("Ceci est une boîte de dialogue simple."),
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
