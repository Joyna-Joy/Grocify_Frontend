
import 'package:flutter/material.dart';
import 'package:grocify_frontend/Customer/CustomerModels/OrderModdel.dart';
import 'package:grocify_frontend/Customer/CustomerServices/OrderServices.dart';

class AllOrdersPage extends StatefulWidget {
  @override
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  late Future<Map<String, dynamic>?> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = OrderService.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade900,
                  Colors.green.shade800,
                  Colors.green.shade400
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
            Icon(Icons.line_weight_outlined,color:  Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('View Orders ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasData) {
            final Map<String, dynamic>? data = snapshot.data;

            if (data != null) {
              if (data['success'] == true) {
                final List<Order> orders = List<Order>.from(data['orders'] ?? []);

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    Order order = orders[index];
                    return ListTile(
                      title: Text('Order ID: ${order.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shipping Address: ${order.shippingInfo.address}, ${order.shippingInfo.city}, ${order.shippingInfo.state}, ${order.shippingInfo.country}, ${order.shippingInfo.pincode}, ${order.shippingInfo.phoneNo}'),
                          Text('Order Items:'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: order.orderItems.map((item) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Product Name: ${item.product.productName}'),
                                Text('Title: ${item.product.title}'),
                                Text('Price: \$${item.product.price}'),
                                Image.network(item.product.images), // Add Image widget with network image
                                Text('Quantity: ${item.quantity}'),
                              ],
                            )).toList(),
                          ),
                          Text('Total Price: \$${order.totalPrice.toStringAsFixed(2)}'),
                          Text('User ID: ${order.userId}'),
                          Text('Order Status: ${order.orderStatus}'),
                        ],
                      ),
                      onTap: () {
                        // Navigate to order details page or show more details
                      },
                    );
                  },
                );
              } else {
                final errorMessage = data['message'] ?? 'Unknown error';
                return Center(child: Text('Failed to fetch orders: $errorMessage'));
              }
            } else {
              return Center(child: Text('Data is null'));
            }
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error?.toString() ?? 'Unknown error';
            return Center(child: Text('Error: $errorMessage'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
