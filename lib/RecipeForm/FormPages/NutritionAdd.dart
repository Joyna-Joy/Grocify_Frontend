import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormModel/NutritionModel.dart';
import 'package:grocify_frontend/RecipeForm/FormServices/NutritionService.dart';


class AddNutritionScreen extends StatefulWidget {
  @override
  _AddNutritionScreenState createState() => _AddNutritionScreenState();
}

class _AddNutritionScreenState extends State<AddNutritionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _fiberController = TextEditingController();

  void _addNutrition() {
    final String title = _titleController.text;
    final String content = _contentController.text;
    final String imageUrl = _imageUrlController.text;
    final double calories = double.tryParse(_caloriesController.text) ?? 0.0;
    final double protein = double.tryParse(_proteinController.text) ?? 0.0;
    final double carbohydrates = double.tryParse(_carbohydratesController.text) ?? 0.0;
    final double fat = double.tryParse(_fatController.text) ?? 0.0;
    final double fiber = double.tryParse(_fiberController.text) ?? 0.0;

    if (title.isNotEmpty && content.isNotEmpty && imageUrl.isNotEmpty && calories > 0 && protein > 0 && carbohydrates > 0 && fat > 0 && fiber > 0) {
      final Nutrition newNutritionEntry = Nutrition(
        title: title,
        content: content,
        imageUrl: imageUrl,
        nutritionInfo: {
          'calories': calories,
          'protein': protein,
          'carbohydrates': carbohydrates,
          'fat': fat,
          'fiber': fiber,
        },
      );

      NutritionService.addNutrition(newNutritionEntry)
          .then((_) {
        Navigator.pop(context);
      })
          .catchError((error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to add nutrition entry: $error'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    } else {
      // Show error message if any field is empty or invalid
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all fields with valid data.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF731902),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.arrow_back_ios_new,color: Colors.brown[200],)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_outlined,color:  Colors.brown[200],),
            SizedBox(
              width: 10,
            ),
            Text('Healthy Nutrition',style: TextStyle(color:Colors.brown[200]),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(45.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content of Recipe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image Url',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF731902), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nutrition',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '(per serving)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child:TextField(
                    controller: _caloriesController,
                    keyboardType:TextInputType.number ,
                    decoration: InputDecoration(
                      labelText: 'Calories',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      enabledBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2),
                Text(
                  'kcal',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child:TextField(
                    controller: _proteinController,
                    keyboardType:TextInputType.number ,
                    decoration: InputDecoration(
                      labelText: 'Protein',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      enabledBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'g',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child:TextField(
                    controller: _carbohydratesController,
                    keyboardType:TextInputType.number ,
                    decoration: InputDecoration(
                      labelText: 'Carbohydrates',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      enabledBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'g',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child:TextField(
                    controller: _fatController,
                    keyboardType:TextInputType.number ,
                    decoration: InputDecoration(
                      labelText: 'Fat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      enabledBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'g',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child:TextField(
                    controller: _fiberController,
                    keyboardType:TextInputType.number ,
                    decoration: InputDecoration(
                      labelText: 'Fiber',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      enabledBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder( // Add this line
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFF731902), // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'g',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF731902),
                  foregroundColor: Colors.white,
                  shape: BeveledRectangleBorder(),
                ),
                onPressed: _addNutrition,
                child: Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}