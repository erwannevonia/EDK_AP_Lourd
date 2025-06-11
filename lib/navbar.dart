import 'package:flutter/material.dart';
import 'screens/profil_screen.dart';
import 'screens/devoir_screen.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDK Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ConnectedPage(title: 'EDK Admin'),
    );
  }
}

class ConnectedPage extends StatefulWidget {
  const ConnectedPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ConnectedPage> createState() => _ConnectedPageState();
}

class _ConnectedPageState extends State<ConnectedPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DevoirScreen(),
    const ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      appBar: AppBar(title: const Text('EDK Admin')),

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
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Devoirs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
