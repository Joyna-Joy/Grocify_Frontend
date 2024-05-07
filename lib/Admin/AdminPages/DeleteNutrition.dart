import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormModel/NutritionModel.dart';
import 'package:grocify_frontend/RecipeForm/FormServices/NutritionService.dart';

class NutritionDeletePage extends StatefulWidget {
  @override
  _NutritionDeletePageState createState() => _NutritionDeletePageState();
}

class _NutritionDeletePageState extends State<NutritionDeletePage> {
  List<Nutrition> _nutritionList = [];

  @override
  void initState() {
    super.initState();
    _loadNutrition();
  }

  Future<void> _loadNutrition() async {
    try {
      final nutritionList = await NutritionService.getAllNutritionEntries();
      setState(() {
        _nutritionList = nutritionList;
      });
    } catch (e) {
      print('Failed to load nutrition entries: $e');
    }
  }

  Future<void> _deleteNutrition(String nutritionId) async {
    final nutritionService = NutritionService();
    final response = await nutritionService.deleteNutrition(nutritionId);
    print('Response: $response');
    if (response.containsKey('deletedNutrition')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nutrition deleted successfully'), backgroundColor: Colors.green,),
      );
      // Remove the deleted item from the list
      setState(() {
        _nutritionList.removeWhere((nutrition) => nutrition.id == nutritionId);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete nutrition'), backgroundColor: Colors.red,),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF540D35),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu_rounded, color: Colors.white,),
            SizedBox(width: 10,),
            Text('Nutrition Entries', style: TextStyle(color: Colors.white),),
          ],
        ),
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
      ),
      body: ListView.builder(
        itemCount: _nutritionList.length,
        itemBuilder: (context, index) {
          final nutrition = _nutritionList[index];
          return ListTile(
            leading: Image.network(nutrition.imageUrl),
            title: Text(nutrition.title),
            subtitle: Text(nutrition.content),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red,),
              onPressed: () => _deleteNutrition(nutrition.id!),
            ),
          );
        },
      ),
    );
  }
}
