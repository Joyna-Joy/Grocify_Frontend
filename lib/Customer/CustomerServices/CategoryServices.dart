import 'dart:convert';
import 'package:grocify_frontend/Customer/CustomerModels/CategoryModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  // final String baseUrl = 'http://localhost:3000/api/category';

  Future<void> addCategory(String categoryName, String imageUrl) async {
    try {
      var response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/category/add_category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'categoryName': categoryName,
          'categoryImage': imageUrl,
        }),
      );

      if (response.statusCode == 201) {
        print('Category added successfully');
      } else {
        print('Failed to add category: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to add category: $error');
    }
  }


  Future<List<Category>> getCategories() async {
    var response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/category/view_category'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Category> categories = [];
      data.forEach((category) {
        categories.add(Category(
          categoryName: category['categoryName'],
          categoryImage: category['categoryImage'], id: '',
        ));
      });
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

}
