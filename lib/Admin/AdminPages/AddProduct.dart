import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocify_frontend/Admin/AdminModel/AdminModel.dart';
import 'package:http/http.dart' as http;

class AdminService {
  final String baseUrl = 'http://localhost:3000/api/admin';

  Future<AdminProduct> addProduct(AdminProduct product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addProduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return AdminProduct.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add product');
    }
  }
}

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final AdminService adminService = AdminService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _selectedCategory = 'Treats';
  List<String> _images = [];

  late AdminProduct product; // List to store image URLs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF540D35),
                    Color(0xB88A1556),
                    Color(0xAFD02788),
                  ],)
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_shopping_cart_outlined,color:  Colors.white,),
              SizedBox(
                width: 10,
              ),
              Text('Add Product',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Quantity'),
                ),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: [
                    'Treats',
                    'Chips & Snacks',
                    'Beverages',
                    'Cereal & Grains',
                    'Masalas & Spice',
                    'Provision',
                    'Hygiene Products',
                    'Housewares',
                    'Dairy Products',
                    'Vegetables & Fruits',
                    'Sweets & Desserts',
                    'Accessories',
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(labelText: 'Image URL'),
                  onChanged: (value) {
                    setState(() {
                      _images.add(value); // Add image URL to the list
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Validate and parse quantity and price
                    final String name = _nameController.text.trim();
                    final String description = _descriptionController.text.trim();
                    final String quantityText = _quantityController.text.trim();
                    final String priceText = _priceController.text.trim();

                    if (name.isEmpty || description.isEmpty || quantityText.isEmpty || priceText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All fields are required')),
                      );
                      return;
                    }

                    int? quantity;
                    double? price;
                    try {
                      quantity = int.parse(quantityText);
                      price = double.parse(priceText);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid quantity or price')),
                      );
                      return;
                    }

                    // final product = Product(
                    //   id: '',
                    //   name: name,
                    //   description: description,
                    //   images: _images,
                    //   quantity: quantity,
                    //   price: price,
                    //   categoryId: _selectedCategory,
                    //   discounts: {}, // Initialize discounts as an empty map
                    //   ratings: [],
                    // );
                    adminService.addProduct(product).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Product added successfully')),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add product: $error')),
                      );
                    });
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
            ),
        );}
}
