import 'package:flutter/material.dart';
import 'package:grocify_frontend/api_constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTipScreen extends StatefulWidget {
  @override
  _AddTipScreenState createState() => _AddTipScreenState();
}

class _AddTipScreenState extends State<AddTipScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  Future<void> addTip() async {
    final Map<String, dynamic> tipData = {
      'title': titleController.text,
      'description': descriptionController.text,
      'author': authorController.text,
      'imageUrl': imageUrlController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/tips/addTips'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(tipData),
      );

      if (response.statusCode == 201) {
        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tip added successfully'),
            backgroundColor: Colors.green, // Set color to green for success
          ),
        );
        Navigator.pop(context);
      } else {
        throw Exception('Failed to add tip');
      }
    } catch (e) {
      // Show failure Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add tip'),
          backgroundColor: Colors.red, // Set color to red for failure
        ),
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
            Icon(Icons.restaurant_menu_rounded,color:  Colors.brown[200],),
            SizedBox(
              width: 10,
            ),
            Text('Tips & Tricks',style: TextStyle(color:Colors.brown[200]),),
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
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Tips',
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
              controller: authorController,
              decoration: InputDecoration(
                labelText: 'Author',
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
              controller: imageUrlController,
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

            SizedBox(height: 20.0),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Color(0xFF731902),foregroundColor: Colors.white,shape: BeveledRectangleBorder()),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      authorController.text.isEmpty ||
                      imageUrlController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                  } else {
                    addTip();}
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
