import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocify_frontend/Admin/AdminModel/AdminModel.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class StarRating extends StatelessWidget {
  final double numOfRating;

  StarRating(this.numOfRating);

  @override
  Widget build(BuildContext context) {
    int numOfFullStars = numOfRating.floor();
    bool hasHalfStar = numOfRating - numOfFullStars >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < numOfFullStars) {
          return Icon(Icons.star, color: Colors.yellow[900]);
        } else if (index == numOfFullStars && hasHalfStar) {
          return Icon(Icons.star_half_sharp, color: Colors.yellow[900]);
        } else {
          return Icon(Icons.star_border, color: Colors.yellow[900]);
        }
      }),
    );
  }
}


class ProductScreen extends StatelessWidget {
  final String categoryId;

  ProductScreen({required this.categoryId});

  Future<List<AdminProduct>> getProductsByCategory() async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/admin/products_category/$categoryId'));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return list.map((model) => AdminProduct.fromJson(model)).toList();
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching products: $error');
      throw Exception('Failed to load products: $error');
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
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400
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
              Icon(Icons.production_quantity_limits, color: Colors.white,),
              SizedBox(width: 10),
              Text('Discover Products', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      backgroundColor: Colors.orange.shade100,
      body: FutureBuilder<List<AdminProduct>>(
        future: getProductsByCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  elevation: 3.0,
                  color:Color(0xffffff7e) ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            product.images,
                            fit: BoxFit.cover,
                            height: 150.0,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: IconButton(
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                // Implement adding product to cart functionality
                              },
                            ),
                          ),
                          if (product.discounts.isNotEmpty)
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                color: Colors.red,
                                child: Text(
                                  '${product.discounts.first.value}% off',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              product.title,
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                StarRating(product.numOfRating),
                                SizedBox(width: 4.0),
                                Text(
                                  '(${product.numOfReviews})',
                                  style: TextStyle(fontSize: 18.0, color: Colors.green[900]),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            if (product.discounts.isNotEmpty)
                              Text(
                                '\₹${product.price}',
                                style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.lineThrough,
                                    fontSize: 18.0
                                ),
                              ),
                            Text(
                              '\₹${calculateDiscountedPrice(product)}', // Calculate discounted price
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No products available'));
          }
        },
      ),
    );
  }

  double calculateDiscountedPrice(AdminProduct product) {
    if (product.discounts.isEmpty) {
      return double.parse(product.price);
    } else {
      double discountValue = product.discounts.first.value;
      return double.parse(product.price) - (double.parse(product.price) * (discountValue / 100));
    }
  }
}
