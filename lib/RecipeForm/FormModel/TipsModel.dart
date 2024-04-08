// To parse this JSON data, do
//
//     final tips = tipsFromJson(jsonString);

import 'dart:convert';

List<Tips> tipsFromJson(String str) => List<Tips>.from(json.decode(str).map((x) => Tips.fromJson(x)));

String tipsToJson(List<Tips> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Tips {
  String id;
  String title;
  String description;
  String author;
  String imageUrl;
  List<String> comments; // Add this line



  Tips({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.imageUrl,
    required this.comments, // Add this line

  });

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      id: json['_id'],
      // Ensure that '_id' is the field name in your JSON response
      title: json['title'],
      description: json['description'],
      author: json['author'],
      imageUrl: json['imageUrl'], comments: [],
    );
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "author": author,
    "imageUrl": imageUrl,
  };
}
