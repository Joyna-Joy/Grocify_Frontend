// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  String id;
  String categoryName;
  String categoryImage;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryName": categoryName,
    "categoryImage": categoryImage,
  };
}
