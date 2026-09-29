import 'package:flutter/material.dart';

import 'screens/vault_screen.dart';

void main() => runApp(const TcgVaultApp());

class TcgVaultApp extends StatelessWidget {
  const TcgVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCG Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const VaultScreen(),
    );
  }
}