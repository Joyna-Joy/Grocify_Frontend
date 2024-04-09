// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Product {
  final String id;
  final String name;
  final String description;
  final List<String> highlights;
  final double price;
  final double cuttedPrice;
  final String imagesUrl;
  final String categoryId;
  final int stock;
  final double ratings;
  final int numOfReviews;
  final List<Review> reviews;
  final String userId;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.highlights,
    required this.price,
    required this.cuttedPrice,
    required this.imagesUrl,
    required this.categoryId,
    required this.stock,
    required this.ratings,
    required this.numOfReviews,
    required this.reviews,
    required this.userId,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      highlights: List<String>.from(json['highlights']),
      price: json['price'].toDouble(),
      cuttedPrice: json['cuttedPrice'].toDouble(),
      imagesUrl: json['imagesUrl'],
      categoryId: json['category_id'],
      stock: json['stock'],
      ratings: json['ratings'].toDouble(),
      numOfReviews: json['numOfReviews'],
      reviews: List<Review>.from(json['reviews'].map((review) => Review.fromJson(review))),
      userId: json['user_id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'highlights': highlights,
      'price': price,
      'cuttedPrice': cuttedPrice,
      'imagesUrl': imagesUrl,
      'category_id': categoryId,
      'stock': stock,
      'ratings': ratings,
      'numOfReviews': numOfReviews,
      'reviews': List<dynamic>.from(reviews.map((review) => review.toJson())),
      'user_id': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Review {
  final String userId;
  final String name;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.userId,
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'],
      name: json['name'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}