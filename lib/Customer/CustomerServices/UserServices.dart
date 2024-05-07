import 'dart:convert';
import 'package:grocify_frontend/Customer/CustomerModels/UserModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;


class UserService {

  // final String baseUrl = 'http://localhost:3000/api/user';


  Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/user/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/user/login');
    final response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> updateProfile(String userId, Map<String, dynamic> userData) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/user/updateprofile/$userId');
    final response = await http.put(url, body: jsonEncode(userData), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update');
    }  }

  Future<Map<String, dynamic>> logout() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/user/logout');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to logout');
    }  }

  Future<Map<String, dynamic>> changePassword(String userId, String oldPassword, String newPassword) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/user/changepassword/$userId');
    final response = await http.put(url, body: jsonEncode({
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    }), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to change password');
    }
  }

  static Future<List<User>> fetchAllUsers() async {
  final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/user/viewallusers'));
  if (response.statusCode == 200) {
  List<dynamic> jsonResponse = jsonDecode(response.body);
  List<User> users = jsonResponse.map((userJson) => User.fromJson(userJson)).toList();
  return users;
  } else {
  throw Exception('Failed to load users');
  }
  }


  Future<Map<String, dynamic>> getSingleUser(String userId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/user/getSingleUser/$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to view user');
    }  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/user/deleteUser/$userId');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete');
    }  }
}
