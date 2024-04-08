import 'package:flutter/material.dart';
import 'package:grocify_frontend/Welcome_Page.dart';
import 'package:grocify_frontend/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GroceryListScreen extends StatefulWidget {
  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<String> groceryItems = [];

  @override
  void initState() {
    super.initState();
    fetchGroceryItems();
  }

  void fetchGroceryItems() async {
    final response =
    await http.get(Uri.parse('${ApiConstants.baseUrl}/api/groceryItems'));
    if (response.statusCode == 200) {
      setState(() {
        groceryItems = json.decode(response.body).cast<String>();
      });
    } else {
      throw Exception('Failed to load grocery items');
    }
  }

  void addGroceryItem(String newItem) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/groceryItems'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'item': newItem}),
    );
    if (response.statusCode == 200) {
      fetchGroceryItems();
    } else {
      throw Exception('Failed to add grocery item');
    }
  }

  void deleteGroceryItem(int index) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/api/groceryItems/$index'),
    );
    if (response.statusCode == 200) {
      fetchGroceryItems();
    } else {
      throw Exception('Failed to delete grocery item');
    }
  }

  void updateGroceryItem(int index, String updatedItem) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/api/groceryItems/$index'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'item': updatedItem}),
    );
    if (response.statusCode == 200) {
      fetchGroceryItems();
    } else {
      throw Exception('Failed to update grocery item');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B026B),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list_alt,color:Colors.white),
            SizedBox(
              width: 10,
            ),
            Text('Shoping List',style: TextStyle(color:Colors.white),),
          ],
        ),
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));}, icon:Icon(Icons.arrow_back_ios_new,color:Colors.white,)),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(groceryItems[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete_forever,color:  Color(0xFFEA2626),),
                  onPressed: () {
                    deleteGroceryItem(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit,color: Color(0xFF3B026B) ,),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String updatedItem = groceryItems[index];
                        return AlertDialog(
                          title: Text("Update Item",style: TextStyle(color: Colors.white)),
                          backgroundColor: Color(0xFF3B026B),
                          content: TextField(
                            style: TextStyle(color: Colors.white), // Set text color to white
                            onChanged: (value) {
                              updatedItem = value;
                            },
                            controller: TextEditingController(text: groceryItems[index]),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel",style: TextStyle(color: Colors.white)),
                            ),
                            TextButton(
                              onPressed: () {
                                updateGroceryItem(index, updatedItem);
                                Navigator.of(context).pop();
                              },
                              child: Text("Update",style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF3B026B),
        onPressed: () async {
          String? newItem = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String newItemName = '';
              return AlertDialog(
                title: Text("Add Item",style: TextStyle(color: Colors.white)),
                backgroundColor: Color(0xFF3B026B),
                content: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    newItemName = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel",style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {
                      addGroceryItem(newItemName);
                      Navigator.of(context).pop(newItemName);
                    },
                    child: Text("Add",style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          );
          if (newItem != null && newItem.isNotEmpty) {
            fetchGroceryItems();
          }
        },
        child: Icon(Icons.add_circle_sharp,color: Colors.white),
      ),
    );
  }
}
