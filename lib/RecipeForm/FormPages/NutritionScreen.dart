import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormModel/NutritionModel.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/NutritionAdd.dart';
import 'package:grocify_frontend/RecipeForm/FormServices/NutritionService.dart';
import 'package:grocify_frontend/Welcome_Page.dart';


class NutritionScreen extends StatefulWidget {
  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  late Future<List<Nutrition>> _nutritionEntries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nutritionEntries = NutritionService.getAllNutritionEntries();
  }

  Future<void> _searchNutrition(String query) async {
    setState(() {
      _nutritionEntries = NutritionService.searchNutrition(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));}, icon:Icon(Icons.arrow_back_ios_new,color:  Color(0xFF731902),)),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _searchNutrition(value);
            },
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>AddNutritionScreen() ));}, icon: Icon(Icons.add_circle_rounded, color:  Color(0xFF731902)),),
        ],
      ),
      body: FutureBuilder<List<Nutrition>>(
        future: _nutritionEntries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Nutrition> nutritionEntries = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0, // Increased spacing
                      crossAxisSpacing: 4.0
                    ),
                    itemCount: nutritionEntries.length,
                    itemBuilder: (context, index) {
                      final Nutrition nutritionEntry = nutritionEntries[index];
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            nutritionEntry.imageUrl != null
                                ? Image.network(
                              nutritionEntry.imageUrl!,
                              height: 95,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                                : SizedBox(height: 100),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nutritionEntry.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(nutritionEntry.content),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Calories: ${nutritionEntry.nutritionInfo['calories']}, Protein: ${nutritionEntry.nutritionInfo['protein']}, Carbohydrates: ${nutritionEntry.nutritionInfo['carbohydrates']}, Fat: ${nutritionEntry.nutritionInfo['fat']}, Fiber: ${nutritionEntry.nutritionInfo['fiber']}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
