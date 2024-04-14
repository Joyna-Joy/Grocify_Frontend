import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Staff {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNo;
  final String role;

  Staff({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.role,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNo: json['phone_no'],
      role: json['role'],
    );
  }
}

class StaffViewPage extends StatefulWidget {
  @override
  _StaffViewPageState createState() => _StaffViewPageState();
}

class _StaffViewPageState extends State<StaffViewPage> {
  static const String baseUrl = 'http://localhost:3000/api/staff';

  Future<List<Staff>> _fetchStaff() async {
    final response = await http.get(Uri.parse('$baseUrl/viewallStaff'));

    if (response.statusCode == 200) {
      // Successful fetch
      final responseData = jsonDecode(response.body) as List<dynamic>;
      return responseData.map((data) => Staff.fromJson(data)).toList();
    } else {
      // Error occurred during fetch
      print('View all staff error: ${response.statusCode}');
      return [];
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
            Icon(Icons.person,color:  Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Staff Members ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: FutureBuilder<List<Staff>>(
        future: _fetchStaff(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final staffList = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Change the number of columns as needed
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                final staff = staffList[index];
                return _buildStaffCard(staff);
              },
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }

  Widget _buildStaffCard(Staff staff) {
    return Card(
      color: Colors.grey,
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            staff.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(staff.email),
          SizedBox(height: 5),
          Text(staff.phoneNo),
          SizedBox(height: 5),
          Text(staff.role),
        ],
      ),
    );
  }
}
