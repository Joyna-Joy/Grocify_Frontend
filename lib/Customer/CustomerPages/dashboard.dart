import 'package:flutter/material.dart';
import 'package:grocify_frontend/Customer/CustomerPages/AccountPage.dart';
import 'package:grocify_frontend/Customer/CustomerPages/CartPage.dart';

import 'package:grocify_frontend/Customer/CustomerPages/Category_Page.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    CategoryMenu(),
    AccountPage(),
    AccountScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}




class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network('https://th.bing.com/th/id/OIP.r6aijQ7gtefVW3pa7N_t7AHaFQ?w=232&h=180&c=7&r=0&o=5&dpr=1.4&pid=1.7'), // Replace the URL with your GIF's URL
    );
  }
}

