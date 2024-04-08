import 'dart:convert';
import 'package:grocify_frontend/RecipeForm/FormModel/RecipeProductModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class RecipeProductService {
  // static const String baseUrl = 'http://localhost:3000/api/recipeProducts';

  static Future<List<Recipeproduct>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/recipeProducts/viewProduct'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Recipeproduct.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
  // Add a new product
  static Future<Recipeproduct> addProduct(Recipeproduct product) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/recipeProducts/addProduct'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return Recipeproduct.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add product');
    }
  }

  // Search for products by name
  static Future<List<Recipeproduct>> searchProducts(String name) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/recipeProducts/searchProduct'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Recipeproduct.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }

  // Update a product by ID
  static Future<Recipeproduct> updateProduct(String id, Recipeproduct updatedProduct) async {
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}/api/recipeProducts/updateProduct/$id'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(updatedProduct.toJson()),
    );

    if (response.statusCode == 200) {
      return Recipeproduct.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
  }

  // Upload an image for a product
  static Future<Recipeproduct> uploadImage(String imagePath, Recipeproduct product) async {
    var request = http.MultipartRequest('POST', Uri.parse('${ApiConstants.baseUrl}/api/recipeProducts/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    request.fields['category'] = product.category;
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();
    if (response.statusCode == 201) {
      final responseJson = await response.stream.bytesToString();
      return Recipeproduct.fromJson(jsonDecode(responseJson));
    } else {
      throw Exception('Failed to upload image for product');
    }
  }
}
