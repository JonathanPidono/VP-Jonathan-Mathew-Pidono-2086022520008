import 'package:flutter/material.dart';

class VaultEmptyState extends StatelessWidget {
  const VaultEmptyState({
    super.key,
    required this.query,
    required this.onClear,
  });

  final String query;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 64, color: scheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              query.isEmpty ? 'No cards here' : 'No results for "$query"',
              textAlign: TextAlign.center,
              style: text.titleLarge?.copyWith(color: scheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different name or brand.',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: onClear,
              child: const Text('Clear filters'),
            ),
          ],
        ),
      ),
    );
  }
}
