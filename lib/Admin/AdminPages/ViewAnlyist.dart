// import 'package:flutter/material.dart';
//
// class ViewAnalyticsPage extends StatelessWidget {
//   final AdminService adminService = AdminService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Analytics'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: adminService.getAnalytics(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final Map<String, dynamic> analyticsData = snapshot.data!;
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Total Sales: ${analyticsData['totalSales']}'),
//                   Text('Total Customers: ${analyticsData['totalCustomers']}'),
//                   // Add more analytics data to display as needed
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
