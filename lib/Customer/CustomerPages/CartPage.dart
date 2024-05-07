import 'package:flutter/material.dart';
import 'package:grocify_frontend/Admin/AdminModel/AdminModel.dart';

class CartPage extends StatefulWidget {
  final AdminProduct product;
  final int quantity;

  CartPage({required this.product, required this.quantity});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double totalAmount;

  @override
  void initState() {
    super.initState();
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double price = double.parse(widget.product.price);
    double discountedPrice = widget.product.discounts.isNotEmpty
        ? double.parse(widget.product.price) -
        (double.parse(widget.product.price) *
            (widget.product.discounts.first.value / 100))
        : 0;

    totalAmount = discountedPrice > 0 ? discountedPrice : price;
    totalAmount *= widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product: ${widget.product.productName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Quantity: ${widget.quantity}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Total Amount: ₹$totalAmount',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Your Order is Placed Successfully',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/OrderGif.gif', // Replace 'assets/order_placed_image.png' with your image asset path
                            width: 200,
                            height: 200,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the bottom sheet
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('OK'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Place Order'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
