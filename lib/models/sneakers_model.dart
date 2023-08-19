import 'dart:convert';

List<Sneakers> sneakerFromJson(String str) =>
    List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

class Sneakers {
  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<dynamic> sizes;
  final String price;
  final String description;
  final String title;

  Sneakers({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.title,
  });

  factory Sneakers.fromJson(Map<String, dynamic> json) {
    return Sneakers(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      imageUrl: List<String>.from(json['imageUrl'].map((x) => x)),
      oldPrice: json['oldPrice'] as String,
      sizes: List<dynamic>.from(json['sizes'].map((x) => x)),
      price: json['price'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
    );
  }
}
