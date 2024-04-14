// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String id;
  final String productName;
  final String title;
  final String description;
  final String images;
  final String quantity;
  final String price;
  final String categoryId;
  final String stock;

  Product({
    required this.id,
    required this.productName,
    required this.title,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,
    required this.categoryId,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productName: json['product_name'],
      title: json['title'],
      description: json['description'],
      images: json['images'],
      quantity: json['quantity'],
      price: json['price'],
      categoryId: json['category_id'],
      stock: json['stock'],
    );
  }

  toJson() {}
}
