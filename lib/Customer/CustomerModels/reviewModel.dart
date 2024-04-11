// To parse this JSON data, do
//
//     final customerReview = customerReviewFromJson(jsonString);

import 'dart:convert';

List<CustomerReview> customerReviewFromJson(String str) => List<CustomerReview>.from(json.decode(str).map((x) => CustomerReview.fromJson(x)));

String customerReviewToJson(List<CustomerReview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerReview {
  String vendorId;
  String customerName;
  String productName;
  String rating;
  String comment;
  DateTime date;

  CustomerReview({
    required this.vendorId,
    required this.customerName,
    required this.productName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    vendorId: json["vendorId"],
    customerName: json["customerName"],
    productName: json["productName"],
    rating: json["rating"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "vendorId": vendorId,
    "customerName": customerName,
    "productName": productName,
    "rating": rating,
    "comment": comment,
    "date": date.toIso8601String(),
  };
}