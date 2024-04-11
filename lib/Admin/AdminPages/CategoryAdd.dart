import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  Future<void> addCategory() async {
    final Map<String, dynamic> CategoryData = {
      'categoryName': titleController.text,
      'categoryImage': imageUrlController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/category/add_category'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(CategoryData),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        throw Exception('Failed to add Category');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add Category'),
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
            Icon(Icons.category,color:  Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Add Category ',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color:Color(0xFF540D35), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF540D35), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color:Color(0xFF540D35), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image Url',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color:Color(0xFF540D35), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                enabledBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color:Color(0xFF540D35), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
                focusedBorder: OutlineInputBorder( // Add this line
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF540D35), // Color of the border
                    width: 2.0, // Width of the border
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Color(0xFF540D35),foregroundColor: Colors.white,shape: BeveledRectangleBorder()),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      imageUrlController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                  } else {
                    addCategory();}
                },
                child: Text('Save',style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
