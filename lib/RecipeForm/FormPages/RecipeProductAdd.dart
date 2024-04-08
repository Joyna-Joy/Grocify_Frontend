import 'package:flutter/material.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  Future<void> addProduct() async {
    final Map<String, dynamic> productData = {
      'name': nameController.text,
      'description': descriptionController.text,
      'price': double.parse(priceController.text),
      'category': categoryController.text,
      'imageUrl': imageUrlController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/recipeProducts/addProduct'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(productData),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF731902),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.arrow_back_ios_new,color: Colors.brown[200],)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart,color:  Colors.brown[200],),
            SizedBox(
              width: 10,
            ),
            Text('Product Review',style: TextStyle(color:Colors.brown[200]),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Product Review',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Item Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image Url',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Color(0xFF731902),foregroundColor: Colors.white,shape: BeveledRectangleBorder()),
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      categoryController.text.isEmpty ||
                      imageUrlController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                  } else {
                    addProduct();
                  }
                },
                child: Text('Save',style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
