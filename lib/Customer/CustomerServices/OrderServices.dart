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
  static Future<Map<String, dynamic>> getAllOrders() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/order/all_orders'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success'] == true) {
          List<Order> orders = (data['orders'] as List)
              .map((orderJson) => Order.fromJson(orderJson))
              .toList();
          return {'success': true, 'orders': orders};
        } else {
          return {'success': false, 'message': 'Failed to fetch orders'};
        }
      } else {
        return {'success': false, 'message': 'Failed to fetch orders'};
      }
    } catch (e) {
      print('Error getting all orders: $e');
      return {'success': false, 'message': 'Internal server error'};
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
