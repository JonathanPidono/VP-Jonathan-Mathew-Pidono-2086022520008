import 'package:flutter/material.dart';

import '../models/tcg_card.dart';

class VaultSearchField extends StatelessWidget {
  const VaultSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Search cards...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class BrandFilterBar extends StatelessWidget {
  const BrandFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: selected == null,
            onSelected: (_) => onSelected(null),
          ),
          for (final name in brandNames)
            ChoiceChip(
              label: Text(name),
              selected: selected == name,
              onSelected: (_) => onSelected(name),
            ),
        ],
      ),
    );
  }
}