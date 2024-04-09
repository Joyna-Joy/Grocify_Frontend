import 'dart:convert';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class OrderService {

  // Create New Order
  static Future<Map<String, dynamic>> createOrder(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse('${ApiConstants.baseUrl}/api/order/new_order'), body: json.encode(data));
    return json.decode(response.body);
  }

  // Get Single Order Details
  static Future<Map<String, dynamic>> getOrder(String id) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/order/getOrder/$id'));
    return json.decode(response.body);
  }

  // Get Logged In User Orders
  static Future<Map<String, dynamic>> getUserOrders() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/order/my_orders'));
    return json.decode(response.body);
  }

  // Get All Orders (Admin)
  static Future<Map<String, dynamic>> getAllOrders() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/order/all_orders'));
    return json.decode(response.body);
  }

  // Update Order Status (Admin)
  static Future<Map<String, dynamic>> updateOrderStatus(String id, String status) async {
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}/api/order/updateOrder/$id'),
      body: json.encode({'status': status}),
    );
    return json.decode(response.body);
  }

  // Delete Order (Admin)
  static Future<Map<String, dynamic>> deleteOrder(String id) async {
    final response = await http.delete(Uri.parse('${ApiConstants.baseUrl}/api/order/deleteOrder/$id'));
    return json.decode(response.body);
  }

  // Cancel Order
  static Future<Map<String, dynamic>> cancelOrder(String id) async {
    final response = await http.put(Uri.parse('${ApiConstants.baseUrl}/api/order/cancel_order/$id'));
    return json.decode(response.body);
  }

  // Return Order
  static Future<Map<String, dynamic>> returnOrder(String id) async {
    final response = await http.put(Uri.parse('${ApiConstants.baseUrl}/api/order/return_order/$id'));
    return json.decode(response.body);
  }
}
