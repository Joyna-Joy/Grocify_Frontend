

import 'dart:convert';

import 'package:grocify_frontend/Customer/CustomerModels/ProductModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;


class ProductApiService{
  Future<List<Product>> getProduct() async{
    var client=http.Client();
    var apiUrl=Uri.parse("${ApiConstants.baseUrl}/api/product/viewproduct");
    var response=await client.get(apiUrl);
    if(response.statusCode==200)
    {
      return productFromJson(response.body);
    }
    else
    {
      return [];
    }
  }
  Future<List<Product>> getProductByCategory(String category_id) async {
    var apiUrl = Uri.parse("${ApiConstants
        .baseUrl}/api/product/product_category?category_id=$category_id");
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    }
    else {
      return [];
    }
  }
    Future<Product> getProductDetails(String productId) async{
      var apiUrl=Uri.parse("${ApiConstants.baseUrl}/api/product/product_details?productId=$productId");
      var response=await http.get(apiUrl);
      if(response.statusCode==200)
      {
        return Product.fromJson(jsonDecode(response.body));
      }
      else
      {
        throw Exception("failed to load user details");
      }
    }
  }

  Future<List<Product>> getSearchedProduct(String search) async {
    var apiUrl = Uri.parse(
        "${ApiConstants.baseUrl}/api/product/search_products?search=$search");
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    }
    else {
      return [];
    }
  }
    Future<String> uploadProduct(Map<String, dynamic> productData) async {
      try {
        var uri = Uri.parse('${ApiConstants.baseUrl}/api/product/product_upload');
        var response = await http.post(
          uri,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(productData),
        );

        if (response.statusCode == 200) {
          return "Successfully uploaded";
        } else {
          return "Failed to upload product";
        }
      } catch (e) {
        print(e.toString());
        return "Error: ${e.toString()}";
      }
    }

     Future<Map<String, dynamic>> deleteProduct(String productId) async {
      final url = Uri.parse('${ApiConstants.baseUrl}/api/product/delete_product/$productId');
      try {
        final response = await http.delete(url);
        if (response.statusCode == 200) {
          return {'success': true, 'message': 'Product deleted successfully'};
        } else if (response.statusCode == 404) {
          return {'success': false, 'message': 'Product not found'};
        } else {
          return {'success': false, 'message': 'Failed to delete product'};
        }
      } catch (error) {
        print('Error deleting product: $error');
        return {'success': false, 'message': 'Internal server error'};
      }
    }

     Future<String> editProduct(String productId, Map<String, dynamic> updatedProductData) async {
      try {
        var uri = Uri.parse('${ApiConstants.baseUrl}/api/product/update_product/$productId');
        var response = await http.put(
          uri,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(updatedProductData),
        );

        if (response.statusCode == 200) {
          return "Successfully updated";
        } else {
          return "Failed to update product";
        }
      } catch (e) {
        print(e.toString());
        return "Error: ${e.toString()}";
      }
    }

