// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:grocify_frontend/api_constants.dart';
// import 'package:http/http.dart' as http;
//
// class UserService {
//   // final String baseUrl = 'http://localhost:3000/api/user';
//
//   Future<List<Map<String, dynamic>>> viewOrders(String userId) async {
//     final response = await http.get(
//       Uri.parse('${ApiConstants.baseUrl}/api/user/Vieworders?userId=$userId'), // Pass userId as a query parameter
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       List<dynamic> ordersJson = jsonDecode(response.body);
//       return ordersJson.cast<Map<String, dynamic>>();
//     } else {
//       throw Exception('Failed to view orders');
//     }
//   }
// }
//
// class Order {
//   final String id;
//   final List<dynamic> products;
//   final double totalPrice;
//   final String address;
//   final String userId;
//   final int orderedAt;
//   final int status;
//
//   Order({
//     required this.id,
//     required this.products,
//     required this.totalPrice,
//     required this.address,
//     required this.userId,
//     required this.orderedAt,
//     required this.status,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['_id'],
//       products: json['products'],
//       totalPrice: json['totalPrice'],
//       address: json['address'],
//       userId: json['userId'],
//       orderedAt: json['orderedAt'],
//       status: json['status'],
//     );
//   }
// }
//
// class OrderListPage extends StatefulWidget {
//   const OrderListPage({Key? key}) : super(key: key);
//
//   @override
//   _OrderListPageState createState() => _OrderListPageState();
// }
//
// class _OrderListPageState extends State<OrderListPage> {
//   late List<Order> orders;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchOrders();
//   }
//
//   Future<void> fetchOrders() async {
//     try {
//       final userService = UserService();
//       final List<Map<String, dynamic>> ordersData = await userService.viewOrders('CURRENT_USER_ID_HERE');
//       setState(() {
//         orders = ordersData.map((data) => Order.fromJson(data)).toList();
//       });
//     } catch (e) {
//       print('Error fetching orders: $e');
//       // Handle error
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.green.shade900,
//                   Colors.green.shade800,
//                   Colors.green.shade400
//                 ],)
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.shopping_cart_checkout ,color:  Colors.white,),
//             SizedBox(
//               width: 10,
//             ),
//             Text('Customer Orders ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.green.shade200,
//       body: orders != null
//           ? ListView.builder(
//         itemCount: orders.length,
//         itemBuilder: (context, index) {
//           final order = orders[index];
//           Color tileColor = order.status == 1 ? Colors.green : Colors.red; // Change color based on order status
//           return ListTile(
//             title: Text(order.address),
//             subtitle: Text(order.totalPrice.toString()),
//             tileColor: tileColor,
//           );
//         },
//       )
//           : Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: OrderListPage(),
//   ));
// }
