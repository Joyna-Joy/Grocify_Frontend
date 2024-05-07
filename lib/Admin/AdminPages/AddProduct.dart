import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocify_frontend/Customer/CustomerModels/CategoryModel.dart';
import 'package:grocify_frontend/Customer/CustomerServices/CategoryServices.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class AdminProduct {
  final String id;
  final String productName;
  final String title;
  final String description;
  final List<String> images;
  final double price;
  final String category_id;
  final int stock;
  final double numOfRating;
  final int numOfReviews;

  AdminProduct({
    required this.id,
    required this.productName,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.category_id,
    required this.stock,
    required this.numOfRating,
    required this.numOfReviews,
  });

  factory AdminProduct.fromJson(Map<String, dynamic> json) {
    return AdminProduct(
      id: json['id'] ?? '',
      productName: json['productName'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      price: json['price'].toDouble(),
      category_id: json['category_id'] ?? '',
      stock: json['stock'] ?? 0,
      numOfRating: json['numOfRating'].toDouble(),
      numOfReviews: json['numOfReviews'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'title': title,
      'description': description,
      'images': images,
      'price': price,
      'category_id': category_id,
      'stock': stock,
      'numOfRating': numOfRating,
      'numOfReviews': numOfReviews,
    };
  }
}

class AdminService {
  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/admin/addProduct'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(productData),
      );

      if (response.statusCode == 200) {
        // Product added successfully
        print('Product added successfully');
      } else {
        // Failed to add product
        print('Failed to add product: ${response.body}');
      }
    } catch (e) {
      // Error occurred
      print('Error adding product: $e');
    }
  }

  Future<bool> validateCategory(String categoryId) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/admin/categories/$categoryId'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return true;
      } else if (response.statusCode == 404) {
        // If the category is not found, return false
        return false;
      } else {
        // If the server returns an error response, throw an exception.
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (e) {
      // Print the error to the console for debugging
      print('Error validating category: $e');
      // If an error occurs, throw an exception with a meaningful message.
      throw Exception('Error validating category: $e');
    }
  }
}

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final AdminService adminService = AdminService();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _numOfRatingController = TextEditingController();
  final TextEditingController _numOfReviewsController = TextEditingController();

  List<Category> categories = [];
  Category? selectedCategory;
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      CategoryService apiService = CategoryService();
      List<Category> fetchedCategories = await apiService.getCategories();

      setState(() {
        categories = fetchedCategories;
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  Future<bool> validateCategory(String categoryId) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/admin/categories/$categoryId'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return true;
      } else if (response.statusCode == 404) {
        // If the category is not found, return false
        return false;
      } else {
        // If the server returns an error response, throw an exception.
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (e) {
      // Print the error to the console for debugging
      print('Error validating category: $e');
      // If an error occurs, throw an exception with a meaningful message.
      throw Exception('Error validating category: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF540D35),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings,color:Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Add Products',style: TextStyle(color:Colors.white),),
          ],
        ),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Product Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Image URL'),
              onChanged: (value) {
                setState(() {
                  _images.add(value); // Add image URL to the list
                });
              },
            ),
            TextField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Stock'),
            ),
            TextField(
              controller: _numOfRatingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number of Ratings'),
            ),
            TextField(
              controller: _numOfReviewsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number of Reviews'),
            ),
            SizedBox(height: 20),
            Text("Select Category", style: TextStyle(fontSize: 16, color: Color(0xFF004225))),
            DropdownButtonFormField<Category>(
              value: selectedCategory,
              onChanged: (Category? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.categoryName),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final String productName = _productNameController.text.trim();
                final String title = _titleController.text.trim();
                final String description = _descriptionController.text.trim();
                final double price = double.tryParse(_priceController.text.trim()) ?? 0;
                final int stock = int.tryParse(_stockController.text.trim()) ?? 0;
                final double numOfRating = double.tryParse(_numOfRatingController.text.trim()) ?? 0;
                final int numOfReviews = int.tryParse(_numOfReviewsController.text.trim()) ?? 0;

                if (productName.isEmpty ||
                    title.isEmpty ||
                    description.isEmpty ||
                    price <= 0 ||
                    stock <= 0 ||
                    numOfRating < 0 ||
                    numOfReviews < 0 ||
                    selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields correctly')),
                  );
                  return;
                }

                final product = AdminProduct(
                  id: '',
                  productName: productName,
                  title: title,
                  description: description,
                  images: _images,
                  price: price,
                  category_id: selectedCategory != null ? selectedCategory!.id : '',
                  stock: stock,
                  numOfRating: numOfRating,
                  numOfReviews: numOfReviews,
                );

                final productData = product.toJson();

                try {
                  // Check if the selected category exists in the database
                  final bool categoryExists = await validateCategory(selectedCategory!.id);
                  if (!categoryExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added successfully')),
                    );
                    return;
                  } else {
                    // Add the product if the category exists
                    await adminService.addProduct(productData);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added successfully')),
                    );
                  }
                } catch (error) {
                  print('Error adding product: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add product: $error')),
                  );
                }
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
