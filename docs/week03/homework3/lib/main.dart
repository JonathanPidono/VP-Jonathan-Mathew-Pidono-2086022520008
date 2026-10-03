import 'package:flutter/material.dart';

import 'screens/vault_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const TcgVaultApp());

class TcgVaultApp extends StatelessWidget {
  const TcgVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCG Vault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const VaultScreen(),
    );
  }
}
