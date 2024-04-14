import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocify_frontend/Admin/AdminModel/AdminModel.dart';
import 'package:grocify_frontend/Customer/CustomerPages/CartPage.dart';
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
  final List<String> categoryIds;
  ProductScreen({required this.categoryIds});

  Future<List<AdminProduct>> getProductsByCategory() async {
    List<AdminProduct> products = [];

    try {
      for (String categoryId in categoryIds) {
        final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/admin/products_category/$categoryId'));
        if (response.statusCode == 200) {
          Iterable list = json.decode(response.body);
          products.addAll(list.map((model) => AdminProduct.fromJson(model)));
        } else {
          throw Exception('Failed to load products for category ID: $categoryId. Status code: ${response.statusCode}');
        }
      }
      return products;
    } catch (error) {
      print('Error fetching products: $error');
      throw Exception('Failed to load products: $error');
    }
  }

  double calculateDiscountedPrice(AdminProduct product) {
    if (product.discounts.isEmpty) {
      return double.parse(product.price);
    } else {
      double discountValue = product.discounts.first.value;
      return double.parse(product.price) - (double.parse(product.price) * (discountValue / 100));
    }
  }

  void addToCart(BuildContext context, AdminProduct product) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        int quantity = 1;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: Text('Product: ${product.productName}'),
                    subtitle: Text('Price: ₹${calculateDiscountedPrice(product)}'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                      // Add product to cart
                      addToCartAction(context, product, quantity);
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void addToCartAction(BuildContext context, AdminProduct product, int quantity) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(product: product, quantity: quantity)),
    );
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
                  childAspectRatio: 0.65
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
                              icon: Icon(Icons.wb_incandescent,color: Colors.black,),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(product.productName),
                                      content: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 5),
                                          Text(' ${product.description}'),
                                          SizedBox(height: 10),
                                          Text('Stock: ${product.stock}',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context); // Close the dialog
                                          },
                                          child: Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
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
                            SizedBox(height: 5.0),
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
                            Row(
                              children: [
                                Text('\₹${calculateDiscountedPrice(product)}', // Calculate discounted price
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(width: 120),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.shopping_cart, color: Colors.deepOrange),
                                    onPressed: () => addToCart(context, product),
                                  ),
                                )
                              ],
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
}
