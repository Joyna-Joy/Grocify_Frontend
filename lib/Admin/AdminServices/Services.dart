
import 'dart:convert';
import 'package:grocify_frontend/Admin/AdminModel/AdminModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class AdminProductService {
  static Future<List<AdminProduct>> getProductsByCategory(String categoryId) async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/products_category/$categoryId');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdminProduct.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }


  static Future<AdminProduct> addProduct(Map<String, dynamic> productData) async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/addProduct');

    try {
      final response = await http.post(
        uri,
        body: json.encode(productData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return AdminProduct.fromJson(data);
      } else {
        throw Exception('Failed to add product');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  static Future<void> deleteProduct(String productId) async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/deleteProduct/$productId');

    try {
      final response = await http.delete(uri);
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  static Future<List<AdminProduct>> getAllProducts() async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/getProduct');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdminProduct.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  static Future<Map<String, dynamic>> getAnalytics() async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/analytics');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch analytics');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  static Future<void> setProductDiscount(String productId, Map<String, dynamic> discountData) async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/productDiscount/$productId');

    try {
      final response = await http.post(
        uri,
        body: json.encode(discountData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to set discount');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }
  static Future<void> updateProduct(String productId, Map<String, dynamic> updatedProductData) async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/updateProduct/$productId');

    try {
      final response = await http.patch(
        uri,
        body: json.encode(updatedProductData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  static Future<void> updateDiscount(String discountId, Map<String, dynamic> updatedDiscountData) async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/updateDiscount/$discountId');

    try {
      final response = await http.patch(
        uri,
        body: json.encode(updatedDiscountData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update discount');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  static Future<List<AdminProduct>> getProductsWithDiscounts() async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/productDiscount');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdminProduct.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch products with discounts');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }
}