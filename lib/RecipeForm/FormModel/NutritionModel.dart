import 'dart:convert';

List<Nutrition> recipeFromJson(String str) => List<Nutrition>.from(json.decode(str).map((x) => Nutrition.fromJson(x)));

String nutritionToJson(List<Nutrition> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Nutrition {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final Map<String, double> nutritionInfo;

  Nutrition({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.nutritionInfo,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      nutritionInfo: Map<String, double>.from(json['nutritionInfo']),
    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "nutritionInfo": nutritionInfo,
    "imageUrl": imageUrl,
  };

}
