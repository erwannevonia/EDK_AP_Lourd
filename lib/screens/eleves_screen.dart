import 'package:flutter/material.dart';
import '../models/globals.dart';
import '../models/info_user.dart';

class ElevesScreen extends StatelessWidget {
  const ElevesScreen({super.key});








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Thème sombre comme Spotify
      appBar: AppBar(
        title: const Text('Concerts à venir',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<List<InfoUser>>(
        future: _concerts,
        builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      TextField(
                        controller: artisteController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Artiste',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      TextField(
                        controller: sceneController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Scène',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      TextField(
                        controller: dateController,
                        readOnly: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color.fromARGB(0, 158, 158, 158),
                          border: OutlineInputBorder(),
                          suffixIcon:
                              Icon(Icons.calendar_today, color: Colors.white),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    surface: Colors.black,
                                    onSurface: Colors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedDate != null) {
                            String formatted =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              dateController.text = formatted;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ou spaceBetween, ou center selon ce que tu veux
                        children: [
                          ElevatedButton(
                            onPressed: _searchConcerts,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: const Text('Rechercher'),
                          ),
                          ElevatedButton(
                            onPressed: _reset,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: const Text('Vider les filtres'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Concert concert = snapshot.data![index];
                      return Card(
                        color: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            concert.artiste,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            'Lieu: ${concert.scene}\nDate: ${concert.date}',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          onTap: () {
                            // Navigation vers les détails (à faire plus tard)
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }





  // void _afficherPopup(BuildContext context) {
  //   int idCompte = AppData.instance.idCompte;
  //   String nomCompte = AppData.instance.nomCompte;
    
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Titre de la pop-up"),
  //         content: Text('ID du compte : $idCompte, Nom du compte : $nomCompte'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(), // Fermer la pop-up
  //             child: const Text("Fermer"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  //     appBar: AppBar(
  //       title: const Text('Mon Profil', style: TextStyle(color: Colors.white)),
  //       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  //       elevation: 0,
  //     ),
  //     body: Center(
  //         child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Text("Hello :D"),
  //         ElevatedButton(
  //           // ignore: avoid_print
  //           onPressed: () => _afficherPopup(context),
  //           child: const Text("Une question ?"),
  //         ),
  //       ],
  //     )),
  //   );
  // }
}
