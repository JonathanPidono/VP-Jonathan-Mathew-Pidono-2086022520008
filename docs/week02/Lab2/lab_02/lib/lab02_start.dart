// =============================================================================
// lab02_start.dart — Week 2 Lab: "Kill the God Widget"
// IMT01303305 Visual Programming · Module 1 · UI Layer
//
// HOW TO RUN IT
//   Drop this file into a fresh Flutter project as lib/lab02_start.dart, then:
//     flutter run -t lib/lab02_start.dart
//   Or just paste it over lib/main.dart and run normally.
//
// THIS FILE WORKS. Search, steppers, total and save all behave correctly.
// It is also one StatefulWidget that does everything, and that is the problem.
//
// YOUR TASK  (full brief: weeks/W02_Composition_and_State.md, section 4)
//   1. Draw the widget tree you want ON PAPER before you edit anything.
//   2. Extract at least five widget classes, one file each, under
//      lib/features/menu/presentation/widgets/
//   3. Hoist state correctly. The screen owns the item list, the query and the
//      quantities. No child may own data that another child needs.
//   4. Every child that can be const, is.
//   5. Every controller is disposed.
//   6. Behaviour identical when you finish. Same features, no regressions.
//
// Each of those six points has at least one thing to fix in here. Find them by
// reading the code, not by guessing.
//
// NOT this week's problem: the hard-coded sizes and the two raw Colors.grey.
// Week 3 is the theming lab. Leave them, or fix them if you cannot bear it.
// =============================================================================

import 'package:flutter/material.dart';

import 'features/menu/presentation/widgets/menu_empty_state.dart';
import 'features/menu/presentation/widgets/menu_header.dart';
import 'features/menu/presentation/widgets/menu_item_card.dart';
import 'features/menu/presentation/widgets/menu_search_field.dart';
import 'features/menu/presentation/widgets/menu_total_bar.dart';

void main() => runApp(const Lab02App());

class Lab02App extends StatelessWidget {
  const Lab02App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warung Digital',
      theme: ThemeData(colorSchemeSeed: Color(0xFF00696E)),
      home: MenuScreen(),
    );
  }
}

class MenuItem {
  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.promo = false,
  });

  final String id;
  final String name;
  final int price;
  final bool promo;
}

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> _items = [
    MenuItem(id: 'm1', name: 'Nasi Goreng Spesial', price: 18000, promo: true),
    MenuItem(id: 'm2', name: 'Mie Ayam Bakso', price: 15000),
    MenuItem(id: 'm3', name: 'Sate Ayam (10 tusuk)', price: 25000),
    MenuItem(id: 'm4', name: 'Ayam Geprek Sambal Matah', price: 20000, promo: true),
    MenuItem(id: 'm5', name: 'Soto Ayam Lamongan', price: 17000),
    MenuItem(id: 'm6', name: 'Es Teh Manis', price: 5000),
    MenuItem(id: 'm7', name: 'Es Jeruk Peras', price: 8000),
    MenuItem(id: 'm8', name: 'Kopi Susu Gula Aren', price: 12000),
  ];

  final Map<String, int> _quantities = {};

  late TextEditingController _searchController;
  late ScrollController _listController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _listController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> visible = [];
    for (MenuItem item in _items) {
      if (_query.isEmpty ||
          item.name.toLowerCase().contains(_query.toLowerCase())) {
        visible.add(item);
      }
    }

    int total = 0;
    int lineCount = 0;
    _quantities.forEach((String id, int qty) {
      if (qty > 0) {
        lineCount = lineCount + 1;
        for (MenuItem item in _items) {
          if (item.id == id) {
            total = total + (item.price * qty);
          }
        }
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Warung Digital')),
      body: Column(
        children: [
          MenuHeader(),
          MenuSearchField(
            controller: _searchController,
            query: _query,
            onChanged: (String value) {
              setState(() => _query = value);
            },
            onClear: () {
              _searchController.clear();
              setState(() => _query = '');
            },
          ),

          Expanded(
            child: visible.isEmpty
                ? MenuEmptyState(
                    query: _query,
                    onClearSearch: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  )
                : ListView.builder(
                    controller: _listController,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: visible.length,
                    itemBuilder: (BuildContext context, int index) {
                      MenuItem item = visible[index];
                      int qty = _quantities[item.id] ?? 0;
                      return MenuItemCard(
                        item: item,
                        qty: qty,
                        onIncrement: () {
                          setState(() {
                            _quantities[item.id] = qty + 1;
                          });
                        },
                        onDecrement: () {
                          setState(() {
                            _quantities[item.id] = qty - 1;
                          });
                        },
                      );
                    },
                  ),
          ),

          MenuTotalBar(
            lineCount: lineCount,
            total: total,
            onSave: total == 0
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pesanan disimpan: Rp $total')),
                    );
                    setState(() => _quantities.clear());
                  },
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// When you are done, answer both of these in your commit message:
//
//   * How many widget classes did you extract, and for each one: was the
//     trigger reuse, or readability?
//
//       - PriceChip = Reuse 
//       - MenuItemCard = Reuse
//       - MenuHeader = Readability
//       - MenuSearchField = Readability
//       - MenuEmptyState = Readability
//       - MenuTotalBar = Readability
//
//   * Which piece of state did you nearly push down into a child widget, and
//     what would have broken if you had?
//
//     Kalau dilakukan, yang rusak: MenuTotalBar menghitung total/lineCount 
//     dari _quantities milik parent, bukan dari state internal kartu, jadi 
//     total tidak akan ikut berubah saat qty di kartu naik-turun. Tombol 
//     Simpan pun ikut salah karena onSave bergantung pada total itu. 
//     _quantities.clear() setelah simpan tidak akan mereset angka di kartu, 
//     karena kartu tidak terhubung ke map itu sama sekali.
//
// Commit: refactor: decompose menu screen into composed widgets
// =============================================================================