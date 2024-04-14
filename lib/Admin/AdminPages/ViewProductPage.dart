import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:grocify_frontend/Admin/AdminServices/Services.dart';
import 'package:grocify_frontend/api_constants.dart';

class ProductListView extends StatelessWidget {
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
              ],
            ),
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
            Icon(Icons.list, color: Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Product List ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: FutureBuilder<List<AdminViewProduct>>(
        future: AdminViewProductService.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(product.images),
                      radius: 30,
                    ),
                    title: Text(product.productName),
                    subtitle: Text('${product.title} \n ₹${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.purple),
                          onPressed: () {
                            _showUpdateDialog(context, product);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showConfirmationDialog(context, product.id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to product details page or perform any other action
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Unknown error occurred'));
          }
        },
      ),
    );
  }

  Future<void> _showUpdateDialog(BuildContext context, AdminViewProduct product) async {
    // Define controller for text fields
    TextEditingController titleController = TextEditingController(text: product.title);
    TextEditingController priceController = TextEditingController(text: product.price);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                try {
                  // Prepare updated product data
                  Map<String, dynamic> updatedData = {
                    'title': titleController.text,
                    'price': double.parse(priceController.text),
                    // Add other fields if necessary
                  };

                  await AdminProductService.updateProduct(product.id, updatedData);
                  Navigator.of(context).pop();
                } catch (error) {
                  // Handle error
                  print('Error updating product: $error');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context, String productId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this product?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                try {
                  await AdminProductService.deleteProduct(productId);
                  Navigator.of(context).pop();
                } catch (error) {
                  // Handle error
                  print('Error deleting product: $error');
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class AdminViewProductService {
  static Future<List<AdminViewProduct>> getAllProducts() async {
    final Uri uri = Uri.parse('${ApiConstants.baseUrl}/api/admin/getProduct');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => AdminViewProduct.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products'); // Provide specific error message
      }
    } catch (error) {
      print(error);
      throw Exception('Network error: $error');
      // Provide specific error message
    }
  }
}

class AdminViewProduct {
  final String id;
  final String productName;
  final String title;
  final String images;
  final String price;

  AdminViewProduct({
    required this.id,
    required this.productName,
    required this.title,
    required this.images,
    required this.price,
  });

  factory AdminViewProduct.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Failed to parse product. JSON is null.');
    }
    return AdminViewProduct(
      id: json['_id'] ?? '', // Ensure _id is treated as String
      productName: json['product_name'] ?? '',
      title: json['title'] ?? '',
      images: json['images'] ?? '',
      price: json['price'].toString() ?? '',
    );
  }
}
