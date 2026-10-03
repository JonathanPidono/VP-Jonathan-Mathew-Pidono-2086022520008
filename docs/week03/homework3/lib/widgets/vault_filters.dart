import 'package:flutter/material.dart';

import '../models/tcg_card.dart';

class VaultSearchField extends StatefulWidget {
  const VaultSearchField({
    super.key,
    required this.query,
    required this.onChanged,
  });

  final String query;
  final ValueChanged<String> onChanged;

  @override
  State<VaultSearchField> createState() => _VaultSearchFieldState();
}

class _VaultSearchFieldState extends State<VaultSearchField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.query);

  @override
  void didUpdateWidget(VaultSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != _controller.text) {
      _controller.text = widget.query;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: SearchBar(
        controller: _controller,
        hintText: 'Search cards...',
        leading: const Icon(Icons.search),
        onChanged: widget.onChanged,
        trailing: [
          if (widget.query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Clear search',
              onPressed: _clear,
            ),
        ],
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
