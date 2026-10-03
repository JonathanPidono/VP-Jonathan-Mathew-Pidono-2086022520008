import 'package:flutter/material.dart';

import '../models/tcg_card.dart';
import '../widgets/card_widgets.dart';
import '../widgets/vault_empty_state.dart';
import '../widgets/vault_filters.dart';
import '../widgets/vault_summary.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  List<TcgCard> _cards = const [];
  bool _loading = true;
  String _query = '';
  String? _brand;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _cards = sampleCards;
      _loading = false;
    });
  }

  void _onQueryChanged(String value) => setState(() => _query = value);

  void _onBrandSelected(String? brand) => setState(() => _brand = brand);

  void _toggleFavorite(String id) {
    setState(() {
      _cards = [
        for (final c in _cards)
          if (c.id == id) c.copyWith(isFavorite: !c.isFavorite) else c,
      ];
    });
  }

  void _clearFilters() => setState(() {
        _query = '';
        _brand = null;
      });

  @override
  Widget build(BuildContext context) {
    final visible = _cards.where((c) {
      final matchesBrand = _brand == null || c.brand == _brand;
      final matchesQuery =
          c.name.toLowerCase().contains(_query.trim().toLowerCase());
      return matchesBrand && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('TCG Vault')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                VaultSummary(
                  totalCards: _cards.length,
                  totalValue: _cards.fold(0, (sum, c) => sum + c.valueRupiah),
                ),
                VaultSearchField(query: _query, onChanged: _onQueryChanged),
                BrandFilterBar(selected: _brand, onSelected: _onBrandSelected),
                Expanded(
                  child: visible.isEmpty
                      ? VaultEmptyState(query: _query, onClear: _clearFilters)
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: visible.length,
                          itemBuilder: (context, i) => CardTile(
                            key: ValueKey(visible[i].id),
                            card: visible[i],
                            onToggleFavorite: () =>
                                _toggleFavorite(visible[i].id),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}