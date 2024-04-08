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


  static Future<Tips> uploadAndAddTip(Tips tip, String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('${ApiConstants.baseUrl}/api/tips/upload'));
    request.fields['title'] = tip.title;
    request.fields['description'] = tip.description;
    request.fields['author'] = tip.author;
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();
    if (response.statusCode == 201) {
      final responseJson = await response.stream.bytesToString();
      return Tips.fromJson(jsonDecode(responseJson));
    } else {
      throw Exception('Failed to upload and add tip');
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
}
