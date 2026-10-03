import 'package:flutter/material.dart';

class VaultSummary extends StatelessWidget {
  const VaultSummary({
    super.key,
    required this.totalCards,
    required this.totalValue,
  });

  final int totalCards;
  final int totalValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Card(
      color: scheme.primaryContainer,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estimated value',
              style: text.labelLarge?.copyWith(color: scheme.onPrimaryContainer),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Rp$totalValue',
                style: text.displaySmall?.copyWith(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$totalCards cards in your vault',
              style: text.bodyLarge?.copyWith(color: scheme.onPrimaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
