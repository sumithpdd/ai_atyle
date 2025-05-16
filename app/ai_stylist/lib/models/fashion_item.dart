class FashionItem {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final String brand;
  final double price;
  final List<String> tags;
  final String mood;
  final String styleType;
  final List<String> sizes;
  final List<String> colors;

  FashionItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.brand,
    required this.price,
    required this.tags,
    required this.mood,
    required this.styleType,
    this.sizes = const [],
    this.colors = const [],
  });

  factory FashionItem.fromJson(Map<String, dynamic> json) {
    return FashionItem(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      tags: List<String>.from(json['tags'] as List),
      mood: json['mood'] as String,
      styleType: json['styleType'] as String,
      sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : [],
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
      'brand': brand,
      'price': price,
      'tags': tags,
      'mood': mood,
      'styleType': styleType,
      'sizes': sizes,
      'colors': colors,
    };
  }
}
