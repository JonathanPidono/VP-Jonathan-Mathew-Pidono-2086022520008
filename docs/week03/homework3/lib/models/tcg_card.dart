class TcgCard {
  const TcgCard({
    required this.id,
    required this.name,
    required this.brand,
    required this.rarity,
    required this.valueRupiah,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String brand;
  final String rarity;
  final int valueRupiah;
  final bool isFavorite;

  TcgCard copyWith({bool? isFavorite}) => TcgCard(
        id: id,
        name: name,
        brand: brand,
        rarity: rarity,
        valueRupiah: valueRupiah,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

const brandNames = ['Pokémon', 'Yu-Gi-Oh!', 'Magic'];

const sampleCards = <TcgCard>[
  TcgCard(id: '1', name: 'Charizard ex', brand: 'Pokémon', rarity: 'Double Rare', valueRupiah: 450000),
  TcgCard(id: '2', name: 'Pikachu VMAX', brand: 'Pokémon', rarity: 'Ultra Rare', valueRupiah: 320000, isFavorite: true),
  TcgCard(id: '3', name: 'Blue-Eyes White Dragon', brand: 'Yu-Gi-Oh!', rarity: 'Ultra Rare', valueRupiah: 1200000),
  TcgCard(id: '4', name: 'Dark Magician', brand: 'Yu-Gi-Oh!', rarity: 'Super Rare', valueRupiah: 275000),
  TcgCard(id: '5', name: 'Black Lotus', brand: 'Magic', rarity: 'Rare', valueRupiah: 150000, isFavorite: true),
  TcgCard(id: '6', name: 'Lightning Bolt', brand: 'Magic', rarity: 'Uncommon', valueRupiah: 60000),
];