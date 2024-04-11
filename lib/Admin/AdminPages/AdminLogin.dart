import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocify_frontend/Admin/AdminPages/AdminPanel.dart';
import 'package:grocify_frontend/Customer/CustomerPages/Login_Page.dart';
import 'package:grocify_frontend/Staff/StaffPages/StaffLogin.dart';


enum Menu { itemOne, itemTwo }

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool _isButtonClicked = false;
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    setState(() {
      _isButtonClicked = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show error message if email or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password'),
          backgroundColor: Colors.red,
        ),
      );

      setState(() {
        _isButtonClicked = false;
      });
      return;
    }

    // Check if the entered credentials match the admin username and password
    if (email == 'admin' && password == 'admin') {
      // Simulate a loading process
      Timer(Duration(seconds: 1), () {
        // Navigate to the CategoryMenu screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
      });
    } else {
      // Show error message for invalid credentials
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
          backgroundColor: Colors.red,
        ),
      );

      setState(() {
        _isButtonClicked = false;
      });
    }
  }


  void _navigateToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), //Add Admin Page
    );
  }
  void _navigateToStaffScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StaffLoginPage()), //Add Admin Page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.arrow_back_ios,color: Colors.white)),
        actions: [
          PopupMenuButton<Menu>(
              icon: Icon(Icons.person_pin, color: Colors.white, size: 25),
              offset: Offset(0, 40),
              onSelected: (Menu item) {
                if (item == Menu.itemOne) {
                  _navigateToLoginScreen();
                }
                else{
                  _navigateToStaffScreen();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.itemOne,
                  child: Text('Customer Login'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemTwo,
                  child: Text('Staff Login'),
                )
              ]),
        ],
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
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF540D35),
              Color(0xB88A1556),
              Color(0xAFD02788),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 55),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xAFD02788),
                                  blurRadius: 80,
                                  offset: Offset(10, 10)),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xAFD02788),
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.email_outlined,
                                          color: Color(0xFF540D35)),
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(
                                        color: Color(0xAFC03683),
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color(0xFF540D35),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Color(0xAFD02788),),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Color(0xFF540D35),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                          !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        CheckboxListTile(
                          value: _rememberMe,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _rememberMe = value;
                            });
                          },
                          title: const Text(
                            'Remember me',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          controlAffinity:
                          ListTileControlAffinity.leading,
                          dense: true,
                          activeColor: Color(0xFF540D35),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        SizedBox(height: 35),
                        InkWell(
                          onTap: () {
                            _handleLogin();
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              height: 50,
                              width: _isButtonClicked ? 200 : 150,
                              decoration: BoxDecoration(
                                color: _isButtonClicked
                                    ? Colors.green
                                    : Color(0xFF540D35),
                                borderRadius: BorderRadius.circular(
                                    _isButtonClicked ? 10 : 50),
                              ),
                              child: Center(
                                  child: _isButtonClicked
                                      ? CircularProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                      : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
