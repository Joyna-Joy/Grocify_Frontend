import 'package:flutter/material.dart';

class Rating {
  final String userId;
  final double rating;
  final String productName;
  final String comment;
  final DateTime date;

  Rating({
    required this.userId,
    required this.rating,
    required this.productName,
    required this.comment,
    required this.date,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userId: json['userId'],
      rating: json['rating'],
      productName: json['product_name'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Discount {
  final String productId;
  final String discountType;
  final double value;
  final DateTime startDate;
  final DateTime endDate;

  Discount({
    required this.productId,
    required this.discountType,
    required this.value,
    required this.startDate,
    required this.endDate,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      productId: json['productId'],
      discountType: json['discountType'],
      value: json['value'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}

class AdminProduct {
  final String id;
  final String productName;
  final String title;
  final String description;
  final String images;
  final String price;
  final String categoryId;
  final int stock;
  final double numOfRating;
  final int numOfReviews;
  final List<Rating> rating;
  final List<Discount> discounts;

  AdminProduct({
    required this.id,
    required this.productName,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.categoryId,
    required this.stock,
    required this.numOfRating,
    required this.numOfReviews,
    required this.rating,
    required this.discounts,
  });

  factory AdminProduct.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Failed to parse product. JSON is null.');
    }
    return AdminProduct(
      id: json['_id'] ?? '',
      productName: json['product_name'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: json['images'] ?? '',
      price: json['price'] ?? '',
      categoryId: json['category_id']['_id'] ?? '', // Access the _id field inside category_id object
      stock: json['stock'] ?? 0,
      numOfRating: json['numOfRating'] ?? 1,
      numOfReviews: json['numOfReviews'] ?? 0,
      rating: (json['rating'] as List<dynamic>?)
          ?.map((ratingJson) => Rating.fromJson(ratingJson))
          .toList() ?? [],
      discounts: (json['discounts'] as List<dynamic>?)
          ?.map((discountJson) => Discount.fromJson(discountJson))
          .toList() ?? [],
    );
  }

}
