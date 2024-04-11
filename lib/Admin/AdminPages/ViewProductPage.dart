import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final int quantity;
  final double price;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      images: List<String>.from(json['images']),
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
    );
  }
}


class ProductViewScreen extends StatelessWidget {
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/admin/getProduct'));
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return List<Product>.from(list.map((model) => Product.fromJson(model)));
    } else {
      throw Exception('Failed to load products');
    }
  }

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
            Icon(Icons.list,color:  Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Product List ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category: ${product.categoryId}', // Changed to categoryId
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Description: ${product.description}'),
                      Text('Quantity: ${product.quantity}'),
                    ],
                  ),
                  trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                  leading: SizedBox(
                    width: 80,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        product.images.isNotEmpty ? product.images.first : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle product tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
