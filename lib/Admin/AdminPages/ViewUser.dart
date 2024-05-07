import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api_constants.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late Future<List<User>> _userListFuture;

  @override
  void initState() {
    super.initState();
    _userListFuture = UserService.fetchAllUsers();
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
            Icon(Icons.perm_identity,color:  Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Users ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: _userListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${user.name}'),
                        Text('Email: ${user.email}'),
                        Text('Phone: ${user.phoneNo}'),
                        // Add more details as needed
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class UserService {
  static Future<List<User>> fetchAllUsers() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/user/viewallusers'));
    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      List<User> users = jsonResponse.map((userJson) => User.fromJson(userJson)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNo;
  final String address;
  final String pincode;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.address,
    required this.pincode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNo: json['phone_no'],
      address: json['address'],
      pincode: json['pincode'],
    );
  }
}
