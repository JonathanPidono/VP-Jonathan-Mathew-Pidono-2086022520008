import 'package:flutter/material.dart';

import 'models/tcg_card.dart';
import 'screens/vault_screen.dart';
import 'theme/app_theme.dart';

const _dataset = String.fromEnvironment('DATA', defaultValue: 'normal');
const _themeName = String.fromEnvironment('THEME', defaultValue: 'system');

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
      themeMode: switch (_themeName) {
        'dark' => ThemeMode.dark,
        'light' => ThemeMode.light,
        _ => ThemeMode.system,
      },
      home: VaultScreen(cards: cardsForDataset(_dataset)),
    );
  }
}
