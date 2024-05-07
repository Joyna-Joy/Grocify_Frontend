import 'dart:convert';
import 'package:grocify_frontend/Customer/CustomerModels/OrderModdel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class OrderService {

  // Create a new order
  static Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/order/new_order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'order': Order.fromJson(jsonDecode(response.body)['order'])};
      } else {
        return {'success': false, 'message': 'Failed to create order'};
      }
    } catch (e) {
      print('Error creating order: $e');
      return {'success': false, 'message': 'Internal server error'};
    }
  }

  // Get details of a single order
  static Future<Map<String, dynamic>> getOrder(String orderId) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/order/getOrder/$orderId'));

      if (response.statusCode == 200) {
        return {'success': true, 'order': Order.fromJson(jsonDecode(response.body)['order'])};
      } else {
        return {'success': false, 'message': 'Order not found'};
      }
    } catch (e) {
      print('Error getting order: $e');
      return {'success': false, 'message': 'Internal server error'};
    }
  }

  // Get all orders (for admin)
  static Future<List<Order>> fetchAllOrders() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/order/all_orders'));
      print('Response Body: ${response.body}'); // Print response body
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Parsed JSON: $jsonResponse'); // Print parsed JSON
        if (jsonResponse['success'] == true) {
          final ordersJson = jsonResponse['orders']; // Accessing the 'orders' key
          List<Order> orders = ordersJson.map<Order>((orderJson) => Order.fromJson(orderJson)).toList();
          return orders;
        } else {
          throw Exception('Failed to load orders: ${response.statusCode}');
        }
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  // Update order status (for admin)
  static Future<Map<String, dynamic>> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiConstants.baseUrl}/api/order/updateOrder/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'status': status}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'order': Order.fromJson(jsonDecode(response.body)['order'])};
      } else {
        return {'success': false, 'message': 'Failed to update order status'};
      }
    } catch (e) {
      print('Error updating order status: $e');
      return {'success': false, 'message': 'Internal server error'};
    }
  }

// Cancel order
  static Future<Map<String, dynamic>> cancelOrder(String orderId) async {
    try {
      final response = await http.put(Uri.parse('${ApiConstants.baseUrl}/api/order/cancel_order/$orderId'));

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'message': 'Failed to cancel order'};
      }
    } catch (e) {
      print('Error canceling order: $e');
      return {'success': false, 'message': 'Internal server error'};
    }
  }

// Return order
  static Future<Map<String, dynamic>> returnOrder(String orderId) async {
    try {
      final response = await http.put(Uri.parse('${ApiConstants.baseUrl}/api/order/return_order/$orderId'));

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'message': 'Failed to return order'};
      }
    } catch (e) {
      print('Error returning order: $e');
      return {'success': false, 'message': 'Internal server error'};
    }
  }

}
