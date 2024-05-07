import 'package:flutter/material.dart';
import 'package:grocify_frontend/Admin/AdminPages/AddProduct.dart';
import 'package:grocify_frontend/Admin/AdminPages/DeleteNutrition.dart';
import 'package:grocify_frontend/Admin/AdminPages/DeleteProductReview.dart';
import 'package:grocify_frontend/Admin/AdminPages/DeleteTips.dart';
import 'package:grocify_frontend/Admin/AdminPages/ViewCategory.dart';
import 'package:grocify_frontend/Admin/AdminPages/CategoryAdd.dart';
import 'package:grocify_frontend/Admin/AdminPages/ViewProductPage.dart';
import 'package:grocify_frontend/Admin/AdminPages/ViewStaff.dart';
import 'package:grocify_frontend/Admin/AdminPages/ViewUser.dart';

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
              ],
            ),
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
            Icon(Icons.admin_panel_settings, color: Colors.white,),
            SizedBox(width: 10,),
            Text('Admin Panel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCard(
              icon: Icons.add_shopping_cart_outlined,
              text: 'Add Product',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage()));
              },
              color: Colors.blue, // Set background color
            ),
            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.category,
              text: 'Add Category',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategoryPage()));
              },
              color: Color(0xBD340101), // Set background color
            ),
            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.list,
              text: 'View Products',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
              },
              color: Colors.green, // Set background color
            ),
            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.shopping_basket,
              text: 'View Orders',
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ManageOrdersPage()));
              },
              color: Colors.orange, // Set background color
            ),
            SizedBox(height: 20.0),
            buildCard(
                icon: Icons.category_outlined,
                text: 'View Category',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCategoryMenu()));
                },
                color: Colors.deepPurple.shade400
            ),
            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.person,
              text: 'View Staff',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StaffViewPage()));
              },
              color: Colors.green.shade900, // Set background color
            ),
            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.person,
              text: 'View User',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserListView()));
              },
              color: Colors.redAccent.shade400, // Set background color
            ),

            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.tips_and_updates,
              text: 'Delete Tips & Tricks ',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TipsDeletePage()));
              },
              color: Color(0xffe3582b), // Set background color
            ),
            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.restaurant_rounded,
              text: 'Delete Healthy Nutrition ',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NutritionDeletePage()));
              },
              color: Color(0xffdcbf09), // Set background color
            ),
            SizedBox(height: 20.0),
            buildCard(
              icon: Icons.production_quantity_limits,
              text: 'Product Review',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeProductDeletePage()));
              },
              color: Color(0xffd91193), // Set background color
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
