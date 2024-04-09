import 'dart:convert';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class StaffService {
  // static const String baseUrl = 'http://localhost:3000/api/staff'; // Replace with your server URL

  // Signup
  static Future<void> signup(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/staff/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Successful signup
      print('Signup success');
    } else {
      // Error occurred during signup
      print('Signup error: ${response.statusCode}');
    }
  }

  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/staff/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful login
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Error occurred during login
      print('Login error: ${response.statusCode}');
      return {'status': 'error'};
    }
  }

  // View all staff
  static Future<List<dynamic>> viewAllStaff() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/staff/viewallStaff'));

    if (response.statusCode == 200) {
      // Successful fetch
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Error occurred during fetch
      print('View all staff error: ${response.statusCode}');
      return [];
    }
  }

  // Update staff
  static Future<void> updateStaff(String id, Map<String, dynamic> updatedData) async {
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}/api/staff/updateStaff/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      // Successful update
      print('Update success');
    } else {
      // Error occurred during update
      print('Update error: ${response.statusCode}');
    }
  }

  // View all orders
  static Future<List<dynamic>> viewAllOrders() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/staff/viewAllOrders'));

    if (response.statusCode == 200) {
      // Successful fetch
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Error occurred during fetch
      print('View all orders error: ${response.statusCode}');
      return [];
    }
  }
}
