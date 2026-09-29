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
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$totalCards cards'),
            Text('Est. value: Rp$totalValue'),
          ],
        ),
      ),
    );
  }
}