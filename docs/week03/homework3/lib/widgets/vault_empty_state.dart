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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search_off, size: 64),
          Text(query.isEmpty ? 'No cards here' : 'No results for "$query"'),
          TextButton(onPressed: onClear, child: const Text('Clear filters')),
        ],
      ),
    );
  }
}