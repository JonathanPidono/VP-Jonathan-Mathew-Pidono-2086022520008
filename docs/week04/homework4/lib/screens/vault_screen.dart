import 'package:flutter/material.dart';

import '../models/tcg_card.dart';
import '../widgets/card_widgets.dart';
import '../widgets/vault_empty_state.dart';
import '../widgets/vault_filters.dart';
import '../widgets/vault_summary.dart';

const double kWideBreakpoint = 600;

const double _sidePanelWidth = 320;

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key, this.cards = sampleCards});

  final List<TcgCard> cards;

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
      _cards = widget.cards;
      _loading = false;
    });
  }

  void _reload() {
    setState(() => _loading = true);
    _load();
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
          : SafeArea(
              top: false, 
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    constraints.maxWidth >= kWideBreakpoint
                        ? _wideLayout(visible)
                        : _compactLayout(visible),
              ),
            ),
    );
  }

  List<Widget> _controls() => [
        VaultSummary(
          totalCards: _cards.length,
          totalValue: _cards.fold(0, (sum, c) => sum + c.valueRupiah),
        ),
        VaultSearchField(query: _query, onChanged: _onQueryChanged),
        BrandFilterBar(selected: _brand, onSelected: _onBrandSelected),
      ];

  Widget _compactLayout(List<TcgCard> visible) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _controls(),
          ),
        ),
        _cardsSliver(visible),
      ],
    );
  }

  Widget _wideLayout(List<TcgCard> visible) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: _sidePanelWidth, child: ListView(children: _controls())),
        const VerticalDivider(width: 1),
        Expanded(
          child: CustomScrollView(slivers: [_cardsSliver(visible)]),
        ),
      ],
    );
  }

  Widget _cardsSliver(List<TcgCard> visible) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: visible.isEmpty
          ? SliverFillRemaining(hasScrollBody: false, child: _emptyState())
          : SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 240,
                mainAxisExtent: 232,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: visible.length,
              itemBuilder: (context, i) {
                final card = visible[i];
                return CardTile(
                  key: ValueKey(card.id),
                  card: card,
                  onToggleFavorite: () => _toggleFavorite(card.id),
                );
              },
            ),
    );
  }

  Widget _emptyState() {
    if (_cards.isEmpty) {
      return VaultEmptyState(
        icon: Icons.inventory_2_outlined,
        title: 'Your vault is empty',
        message: 'Cards you add will show up here.',
        actionLabel: 'Reload',
        onAction: _reload,
      );
    }
    final query = _query.trim();
    return VaultEmptyState(
      icon: Icons.search_off,
      title: query.isEmpty ? 'No cards match' : 'No results for "$query"',
      message: 'Try a different name or brand.',
      actionLabel: 'Clear filters',
      onAction: _clearFilters,
    );
  }
}
