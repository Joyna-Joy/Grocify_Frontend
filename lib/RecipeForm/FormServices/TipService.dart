import 'dart:convert';
import 'package:grocify_frontend/RecipeForm/FormModel/TipsModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class TipApiService {
  // static const String baseUrl = 'http://localhost:3000/api/tips';

  static Future<List<Tips>> getAllTips() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/tips/ViewTips'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((tipJson) => Tips.fromJson(tipJson)).toList();
    } else {
      throw Exception('Failed to load tips');
    }
  }

  static Future<Tips> addTip(Tips tip) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/tips/addTips'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(tip.toJson()),
    );

    if (response.statusCode == 201) {
      return Tips.fromJson(jsonDecode(response.body));
    } else {
      // If the request fails, throw an exception with a meaningful message.
      throw Exception('Failed to add tip: ${response.statusCode}');
    }
  }


  static Future<List<Tips>> searchTips(String title) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/tips/searchTips'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'title': title}),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((tipJson) => Tips.fromJson(tipJson)).toList();
    } else {
      throw Exception('Failed to search tips');
    }
  }
  static Future<void> updateTip(String id, Map<String, dynamic> updatedFields) async {
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}/api/tips/updateTips/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedFields),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update tip');
    }
  }



  static Future<void> addComment(String tipId, String comment) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/tips/addComment'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'tipId': tipId, 'comment': comment}),
      );

      if (response.statusCode == 201) {
        // Comment added successfully
        print('Comment added successfully');
      } else {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      print('Failed to add comment: $e');
      // Handle error
    }
  }

  Future<Map<String, dynamic>> deleteTip(String tipId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/tips/deleteTip/$tipId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Handle other status codes
        return {'success': false, 'message': 'Failed to delete tip'};
      }
    } catch (e) {
      // Handle network errors
      return {'success': false, 'message': 'Network error: $e'};
    }
  }
}
