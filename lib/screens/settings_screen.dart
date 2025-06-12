import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListTile(
        title: const Text('Thème sombre'),
        trailing: Switch(
          value: isDark,
          onChanged: (val) {
            themeProvider.toggleTheme(val);
          },
        ),
      ),
    );
  }
}