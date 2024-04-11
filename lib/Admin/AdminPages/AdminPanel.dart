import 'package:flutter/material.dart';
import 'package:grocify_frontend/Admin/AdminPages/AddProduct.dart';
import 'package:grocify_frontend/Admin/AdminPages/CategoryAdd.dart';
import 'package:grocify_frontend/Admin/AdminPages/ViewProductPage.dart';
import 'package:grocify_frontend/Admin/AdminPages/ViewStaff.dart';
import 'package:grocify_frontend/Customer/CustomerPages/Category_Page.dart';


class AdminScreen extends StatelessWidget {
  var productId;


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
            Icon(Icons.admin_panel_settings,color:  Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Admin Panel ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildListTile(
              icon: Icons.add_shopping_cart_outlined,
              text: 'Add Product',
              onTap: () {
             // Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage()));
              },
              color: Colors.blue, // Set background color
            ),
            SizedBox(height: 20.0),

            buildListTile(
              icon: Icons.category,
              text: 'Add Category',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategoryPage()));
              },
              color: Color(0xBD340101), // Set background color
            ),


            SizedBox(height: 20.0),
            buildListTile(
              icon: Icons.list,
              text: 'View Products',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductViewScreen()));
              },
              color: Colors.green, // Set background color
            ),
            SizedBox(height: 20.0),
            buildListTile(
              icon: Icons.shopping_basket,
              text: 'View Orders',
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ManageOrdersPage()));
              },
              color: Colors.orange, // Set background color
            ),


            SizedBox(height: 20.0),
            buildListTile(
              icon: Icons.category_outlined,
              text: 'View Category',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryMenu()));
              },
              color: Colors.deepPurple.shade400
            ),
            SizedBox(height: 20.0),
            buildListTile(
              icon: Icons.analytics,
              text: 'View Analytics',
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAnalyticsPage()));
              },
              color: Colors.teal, // Set background color
            ),
            SizedBox(height: 20.0),
            buildListTile(
              icon: Icons.person,
              text: 'View Staff',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StaffViewPage()));
              },
              color: Colors.green.shade900, // Set background color
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white, // Set icon color
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Set text color
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}