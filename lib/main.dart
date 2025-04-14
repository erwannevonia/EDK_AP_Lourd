import 'package:flutter/material.dart';

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

  int _currentIndex = 0;

  // final List<Widget> _pages = [
  //   const ConcertListScreen(),
  //   const FavoritesScreen(),
  //   const ProfileScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('EDK Admin')),
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
            )
        ),

        // NavBar
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 38, 246, 253),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.white,
            // currentIndex = la page entre 0 et 1, utilisant le tableau
            // au dessus, _pages
            currentIndex: _currentIndex,
            onTap: (index) {
              // setState indique qu'il faut re-build l'application, puis
              // on indique dans _currentIndex quelle page on est (0, 1, 2)
              setState(() {
                _currentIndex = index;
              });
            },
            // les items sont les diiférentes catégories pour la navbar
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
      );
  }
}
