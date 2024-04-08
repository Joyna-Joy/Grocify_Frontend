import 'dart:convert';

List<Nutrition> recipeFromJson(String str) => List<Nutrition>.from(json.decode(str).map((x) => Nutrition.fromJson(x)));

String nutritionToJson(List<Nutrition> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Nutrition {
  final String title;
  final String content;
  final String? imageUrl;
  final Map<String, double> nutritionInfo;

  Nutrition({
    required this.title,
    required this.content,
    this.imageUrl,
    required this.nutritionInfo,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      nutritionInfo: Map<String, double>.from(json['nutritionInfo']),
    );
  }
  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "nutritionInfo": nutritionInfo,
    "imageUrl": imageUrl,
  };

}
