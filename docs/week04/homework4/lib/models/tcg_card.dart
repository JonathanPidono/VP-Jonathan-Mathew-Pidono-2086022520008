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

final List<TcgCard> longNameCards = <TcgCard>[
  TcgCard(
    id: 'long-1',
    name: ('Dragon ' * 29).substring(0, 200),
    brand: 'Yu-Gi-Oh!',
    rarity: 'Ultra Rare',
    valueRupiah: 1200000,
  ),
  TcgCard(
    id: 'long-2',
    name: 'W' * 200,
    brand: 'Pokémon',
    rarity: 'Double Rare',
    valueRupiah: 450000,
    isFavorite: true,
  ),
  TcgCard(
    id: 'long-3',
    name: 'Black Lotus',
    brand: 'Magic: The Gathering ' * 5,
    rarity: 'Secret Rare Special Collector Edition ' * 4,
    valueRupiah: 150000000,
  ),
  ...sampleCards,
];

final List<TcgCard> bigCards = List<TcgCard>.generate(500, (i) {
  const rarities = ['Common', 'Uncommon', 'Rare', 'Ultra Rare'];
  return TcgCard(
    id: 'big-$i',
    name: 'Card #${i + 1}',
    brand: brandNames[i % brandNames.length],
    rarity: rarities[i % rarities.length],
    valueRupiah: 10000 + (i * 7919) % 1500000,
    isFavorite: i % 7 == 0,
  );
});

List<TcgCard> cardsForDataset(String name) => switch (name) {
      'long' => longNameCards,
      'empty' => const <TcgCard>[],
      'big' => bigCards,
      _ => sampleCards,
    };
