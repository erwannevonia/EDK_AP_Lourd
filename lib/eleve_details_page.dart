import 'package:flutter/material.dart';
import '../models/info_user.dart';
import 'services/api_service.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class EleveDetailsPage extends StatefulWidget {
  final InfoUser eleve;

  const EleveDetailsPage({super.key, required this.eleve});

  @override
  State<EleveDetailsPage> createState() => _EleveDetailsPageState();
}

class _EleveDetailsPageState extends State<EleveDetailsPage> {
  final _mdpController = TextEditingController();
  bool _loading = false;

  String _convertToSHA256(input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> modifierMdp() async {
    setState(() => _loading = true);

    try {
      String input = _mdpController.text;
      String mdp = _convertToSHA256(input);
      final message = await ApiService.updateMotDePasse(widget.eleve.id, mdp);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
    }

    setState(() => _loading = false);
  }

  Future<void> supprimerCompte() async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Supprimer le compte ?"),
        content: const Text("Cette action est irréversible."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Annuler")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Supprimer")),
        ],
      ),
    );

    if (confirmation == true) {
      try {
        final message = await ApiService.deleteEleve(widget.eleve.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final eleve = widget.eleve;

    return Scaffold(
      appBar: AppBar(title: Text("Détails de ${eleve.nom}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID : ${eleve.id}"),
            Text("Nom : ${eleve.nom}"),
            Text("Mail : ${eleve.mail}"),
            Text("Classe : ${eleve.idClasse}"),
            Text("2FA : ${eleve.a2f == 1 ? "Activé" : "Non"}"),
            const SizedBox(height: 24),
            TextField(
              controller: _mdpController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Nouveau mot de passe",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton.icon(
                    onPressed: modifierMdp,
                    icon: const Icon(Icons.lock_reset),
                    label: const Text("Modifier le mot de passe"),
                  ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: supprimerCompte,
              icon: const Icon(Icons.delete_forever),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              label: const Text("Supprimer le compte"),
            ),
          ],
        ),
      ),
    );
  }
}
