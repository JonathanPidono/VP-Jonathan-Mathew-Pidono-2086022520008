class MenuItem {
  final String name;
  final double price;
  final double? discountPercent;

  MenuItem(this.name, this.price, {this.discountPercent});

  double finalPrice() {
    final discount = discountPercent ?? 0;
    return price - (price * discount / 100);
  }

  @override
  String toString() => '$name (Rp ${price.toStringAsFixed(0)})';
}

void main() {
  final menu = <MenuItem>[
    MenuItem('Nasi Goreng Jakarta', 18000, discountPercent: 10),
    MenuItem('Es Teh Manis', 5000, discountPercent: 1),
    MenuItem('Ayam Bakar', 22000, discountPercent: 15),
    MenuItem('Air Mineral', 3000),
    MenuItem('Mie Ayam Bakso', 14000),
  ];

  final names = menu.map((item) => item.name).toList();
  print('Names: $names');

  final cheapItems = menu.where((item) => item.finalPrice() < 15000).toList();
  print('Under 15k: $cheapItems');

  final total = menu.fold<double>(0, (sum, item) => sum + item.finalPrice());
  print('Total: Rp ${total.toStringAsFixed(0)}');
}