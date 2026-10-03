import 'package:flutter/material.dart';

import '../models/tcg_card.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    super.key,
    required this.card,
    required this.onToggleFavorite,
  });

  final TcgCard card;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: Center(child: Icon(Icons.style, size: 48))),
            Text(
              card.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.titleMedium?.copyWith(color: scheme.onSurface),
            ),
            Text(
              '${card.brand} • ${card.rarity}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp${card.valueRupiah}',
                  style: text.bodyLarge?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Material's own toggle: `isSelected` + `selectedIcon` replaces
                // the hand-rolled star / star_border ternary.
                IconButton(
                  isSelected: card.isFavorite,
                  icon: const Icon(Icons.star_border),
                  selectedIcon: const Icon(Icons.star),
                  tooltip: card.isFavorite
                      ? 'Remove from favourites'
                      : 'Add to favourites',
                  onPressed: onToggleFavorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
