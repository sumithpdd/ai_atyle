// Dummy data for AI Stylist

const List<String> examplePrompts = [
  "Plan my outfits better",
  "Look professional at work",
  "Expand my wardrobe",
  "Evolve my style",
  "Wear my clothes more",
  "Check if it matches me",
  "Makeup for my skin tone",
  "Stylist cargo pants",
  "Outfit advice for a friend's wedding",
  "Colors to avoid",
  "Clothing suggestions",
];

class WardrobeItem {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final List<String> colors;

  WardrobeItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.colors,
  });
}

final List<WardrobeItem> dummyWardrobe = [
  WardrobeItem(
    id: '1',
    name: 'Pink Sweater',
    imageUrl: 'assets/pink_sweater.png',
    category: 'Top',
    colors: ['Pink'],
  ),
  WardrobeItem(
    id: '2',
    name: 'Blue Jeans',
    imageUrl: 'assets/blue_jeans.png',
    category: 'Bottom',
    colors: ['Blue'],
  ),
  WardrobeItem(
    id: '3',
    name: 'Yellow Coat',
    imageUrl: 'assets/yellow_coat.png',
    category: 'Outerwear',
    colors: ['Yellow'],
  ),
];

class OutfitIdea {
  final String id;
  final String title;
  final List<String> itemIds;

  OutfitIdea({required this.id, required this.title, required this.itemIds});
}

final List<OutfitIdea> dummyOutfits = [
  OutfitIdea(id: 'o1', title: 'Everyday Outfits', itemIds: ['1', '2', '3']),
];
