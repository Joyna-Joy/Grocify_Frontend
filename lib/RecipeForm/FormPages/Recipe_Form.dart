import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/NutritionScreen.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/RecipeProductScreen.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/TipScreen.dart';


class RecipeForm extends StatefulWidget {
  const RecipeForm({super.key});

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final List<Widget> pages=[
    NutritionScreen(),
    TipsScreen(),
    RecipeProductView(),
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              print(index);
              setState(() {
                currentIndex=index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded,color:Colors.white,),
                  label:"Healthy Nutrition"),
              BottomNavigationBarItem(icon:Icon(Icons.tips_and_updates,color:Colors.white),
                  label: "Tips & Tricks"),
              BottomNavigationBarItem(icon:Icon(Icons.production_quantity_limits,color:Colors.white),
                  label: "Product Review")
            ],
          backgroundColor: Color(0xFF731902),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          elevation: 10, ),
      ),
    );
  }
}
