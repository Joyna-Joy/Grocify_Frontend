import 'package:grocify_frontend/Customer/CustomerModels/ProductModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductServiceApi {

  Future<Map<String, dynamic>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/Viewproducts'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch all products');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> getProductById(String id) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/getproduct/$id'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return {'success': false, 'message': 'Product Not Found'};
      } else {
        throw Exception('Failed to fetch product details');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> getSliders() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/sliders'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch product sliders');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/product/addProduct'),
        body: json.encode(productData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to add product');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> searchProducts(String query) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/search_products?query=$query'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return {'message': 'Search query is required'};
      } else {
        throw Exception('Failed to search products');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> addOrUpdateReview(String productId, Map<String, dynamic> reviewData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/product/reviewsProduct/$productId'),
        body: json.encode(reviewData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return {'success': false, 'message': 'Product not found'};
      } else {
        throw Exception('Failed to add or update review');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> getReviewsByProductId(String productId) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/reviewsProduct/$productId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return {'success': false, 'message': 'Product not found'};
      } else {
        throw Exception('Failed to fetch reviews');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> deleteReview(String productId, String reviewId) async {
    try {
      final response = await http.delete(Uri.parse('${ApiConstants.baseUrl}/api/product/product/$productId/review/$reviewId'));
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Review deleted successfully'};
      } else if (response.statusCode == 404) {
        return {'success': false, 'message': 'Product not found'};
      } else {
        throw Exception('Failed to delete review');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> getProductsByCategoryId(List<String> categoryIds) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/product_category/${categoryIds.join(',')}'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return {'success': false, 'message': 'No products found for the specified categories'};
      } else {
        throw Exception('Failed to fetch products by category');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> addItemToCart(Map<String, dynamic> cartItemData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/product/add_cart'),
        body: json.encode(cartItemData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else if (response.statusCode == 404) {
        return {'message': 'Product not found'};
      } else {
        throw Exception('Failed to add item to cart');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> getCartItems(String userId) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/get_cart/$userId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to retrieve cart');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }

  Future<Map<String, dynamic>> deleteCartItem(String itemId) async {
    try {
      final response = await http.delete(Uri.parse('${ApiConstants.baseUrl}/api/product/delete_item/$itemId'));
      if (response.statusCode == 200) {
        return {'success': true};
      } else if (response.statusCode == 400) {
        return {'message': 'itemId is required'};
      } else if (response.statusCode == 404) {
        return {'message': 'Cart Not Found'};
      } else {
        throw Exception('Failed to delete item from cart');
      }
    } catch (error) {
      throw Exception('Network Error: $error');
    }
  }
}
