import 'dart:convert';
import 'package:grocify_frontend/RecipeForm/FormModel/NutritionModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class NutritionService {
  // static const String baseUrl = 'http://localhost:3000/api/nutrition';


  static Future<List<Nutrition>> getAllNutritionEntries() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/nutrition/viewNutrition'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((data) => Nutrition.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load nutrition entries');
    }
  }

  static Future<List<Nutrition>> searchNutrition(String query) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/nutrition/searchNutrition?q=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((data) => Nutrition.fromJson(data)).toList();
    } else {
      throw Exception('Failed to search for nutrition entries');
    }
  }

  static Future<Nutrition> addNutrition(Nutrition nutrition) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/nutrition/addNutrition'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': nutrition.title,
        'content': nutrition.content,
        'imageUrl': nutrition.imageUrl,
        'nutritionInfo': nutrition.nutritionInfo,
      }),
    );

    if (response.statusCode == 201) {
      return Nutrition.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add nutrition entry');
    }
  }

  Future<Map<String, dynamic>> deleteNutrition(String nutritionId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/nutrition/deleteNutrition/$nutritionId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Handle other status codes
        return {'success': false, 'message': 'Failed to delete nutrition'};
      }
    } catch (e) {
      // Handle network errors
      return {'success': false, 'message': 'Network error: $e'};
    }
  }
}
