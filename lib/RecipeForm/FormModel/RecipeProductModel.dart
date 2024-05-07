// To parse this JSON data, do
//
//     final recipeproduct = recipeproductFromJson(jsonString);

import 'dart:convert';

List<Recipeproduct> recipeproductFromJson(String str) => List<Recipeproduct>.from(json.decode(str).map((x) => Recipeproduct.fromJson(x)));

String recipeproductToJson(List<Recipeproduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipeproduct {
  final String id;
  final String name;
  final String description;
  final int price; // Change the data type to int
  final String category;
  final String imageUrl;
   List<String> comments; // Add this line


  Recipeproduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.comments, // Add this line

  });

  factory Recipeproduct.fromJson(Map<String, dynamic> json) {
    return Recipeproduct(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      imageUrl: json['imageUrl'], comments: [],
    );
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category": category,
    "imageUrl": imageUrl,
  };
}
