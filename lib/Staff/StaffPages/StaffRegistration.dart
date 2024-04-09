import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;

class StaffRegistrationPage extends StatefulWidget {
  const StaffRegistrationPage({Key? key}) : super(key: key);

  @override
  _StaffRegistrationPageState createState() => _StaffRegistrationPageState();
}

class _StaffRegistrationPageState extends State<StaffRegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();


  Future<void> _signup() async {
    try {
      final response = await signup({
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone_no': _phoneController.text,
        'role': _roleController.text,

      });

      // Check if registration was successful
      if (response['status'] == 'success') {
        // Registration successful, navigate to another screen or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to sign up');
      }
    } catch (e) {
      // Registration failed, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign up. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
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
            Icon(Icons.app_registration_sharp,color:  Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Staff Registration ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      backgroundColor: Colors.green.shade200,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set fillColor
                border: Border.all(
                  color: Colors.green.shade900, // Set borderColor
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10), // Add border radius if needed
              ),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.green[500]), // Matched icon for Name
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),

            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set fillColor
                border: Border.all(
                  color: Colors.green.shade900, // Set borderColor
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10), // Add border radius if needed
              ),
              child: Row(
                children: [
                  Icon(Icons.email, color: Colors.green[500]), // Matched icon for Email
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),

            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set fillColor
                border: Border.all(
                  color: Colors.green.shade900, // Set borderColor
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10), // Add border radius if needed
              ),
              child: Row(
                children: [
                  Icon(Icons.lock, color: Colors.green[500]), // Matched icon for Password
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none, // Remove the default border
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set fillColor
                border: Border.all(
                  color: Colors.green.shade900, // Set borderColor
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10), // Add border radius if needed
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.green[500]), // Matched icon for Phone Number
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set fillColor
                border: Border.all(
                  color: Colors.green.shade900, // Set borderColor
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10), // Add border radius if needed
              ),
              child: Row(
                children: [
                  Icon(Icons.perm_contact_cal_outlined, color: Colors.green[500]), // Matched icon for Address
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _roleController,
                      decoration: InputDecoration(
                        labelText: 'Staff Role',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.green[900],foregroundColor: Colors.white,shape: BeveledRectangleBorder()),
                onPressed: () {
                  if (_nameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _phoneController.text.isEmpty ||
                      _roleController.text.isEmpty ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                  } else {
                    _signup();}
                },
                child: Text('SignUp',style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse('${ApiConstants.baseUrl}/api/staff/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to sign up');
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StaffRegistrationPage(),
  ));
}
