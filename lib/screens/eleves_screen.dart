import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../eleve_details_page.dart';
import '../models/info_user.dart';

class ElevesScreen extends StatelessWidget {
  const ElevesScreen({super.key});

  Map<int, List<InfoUser>> regrouperParClasse(List<InfoUser> eleves) {
    Map<int, List<InfoUser>> groupes = {};

    for (var eleve in eleves) {
      groupes.putIfAbsent(eleve.idClasse, () => []).add(eleve);
    }

    return groupes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InfoUser>>(
      future: ApiService.fetchEleves(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erreur: ${snapshot.error}"));
        } else {
          final groupes = regrouperParClasse(snapshot.data!);

          return ListView(
            children: groupes.entries.map((entry) {
              final idClasse = entry.key;
              final eleves = entry.value;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text("Classe $idClasse"),
                  children: eleves.map((eleve) {
                    return ListTile(
                      title: Text(eleve.nom),
                      subtitle: Text(eleve.mail),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EleveDetailsPage(eleve: eleve),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
