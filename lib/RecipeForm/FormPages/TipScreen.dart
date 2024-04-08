import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormModel/TipsModel.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/Recipe_Form.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/TipAddScreen.dart';
import 'package:grocify_frontend/RecipeForm/FormServices/TipService.dart';


class TipsScreen extends StatefulWidget {

  @override
  _TipsScreenState createState() => _TipsScreenState();
}
List<Tips> tipsList = [];


class _TipsScreenState extends State<TipsScreen> {
  List<Tips> tipsList = []; // Assuming Tips model is defined
  Map<String, bool> likedTips = {};
  Map<String, int> commentsCount = {};
  TextEditingController commentController = TextEditingController();

  var tipId;

  @override
  void initState() {
    super.initState();
    loadTips();
  }

  Future<void> loadTips() async {
    try {
      List<Tips> tips = await TipApiService.getAllTips();
      setState(() {
        tipsList = tips;
        // Initialize likedTips map and commentsCount map with default values
        tipsList.forEach((tip) {
          likedTips[tip.id] = false;
          commentsCount[tip.id] = 0;
        });
      });
    } catch (e) {
      print('Failed to load tips: $e');
    }
  }

  void toggleLike(String tipId) {
    setState(() {
      likedTips[tipId] = !likedTips[tipId]!;
    });
  }
  void addComment(String tipId, String comment) {
    setState(() {
      // Check if the comment already exists in the list
      final tip = tipsList.firstWhere((tip) => tip.id == tipId);
      if (!tip.comments.contains(commentController.text)) {
        // Increment comments count for the corresponding tip
        commentsCount[tipId] = (commentsCount[tipId] ?? 0) + 1;
        // Add the comment to the comments list
        tip.comments.add(commentController.text);
      }
    });

    // Perform logic to add comment to backend (not implemented here)
    // You can use the commentController.text to get the comment text
    // and call the appropriate API service to add the comment
    commentController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu_rounded,color:  Color(0xFF731902),),
                SizedBox(
                  width: 10,
                ),
                Text('Tips & Tricks',style: TextStyle(color:  Color(0xFF731902)),),
              ],
            ),
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeForm()));}, icon:Icon(Icons.arrow_back_ios_new,color:  Color(0xFF731902),)),
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>AddTipScreen() ));}, icon: Icon(Icons.add_circle_rounded, color:  Color(0xFF731902)),),
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>SearchTips() ));},icon: Icon(Icons.search, color:  Color(0xFF731902)),),
        ],
      ),
      body: tipsList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: tipsList.length,
        itemBuilder: (context, index) {
          final tip = tipsList[index];
          final isLiked = likedTips[tip.id] ?? false;
          return Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tip.imageUrl != null)
                    Image.network(
                      tip.imageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 10),
                  Text(
                    tip.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    tip.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Author: ${tip.author}',
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ?  Color(0xFFFF0000) : null,
                        ),
                        onPressed: () => toggleLike(tip.id),
                      ),
                      IconButton(
                        icon: Icon(Icons.comment, color:  Color(0xFF731902)),
                        onPressed: () {
                          // Show comments dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: Text('Comments', style: TextStyle(color: Color(0xFF731902))),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Display existing comments (if any)
                                        if (commentsCount[tip.id] != null && commentsCount[tip.id]! > 0)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: List.generate(
                                              commentsCount[tip.id]!,
                                                  (index) => Text('Comment ${index + 1}: ${tip.comments[index]}'),
                                            ),
                                          ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: commentController,
                                          decoration: InputDecoration(
                                            hintText: 'Add a comment',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Add the comment locally
                                          setState(() {
                                            commentsCount[tip.id] = (commentsCount[tip.id] ?? 0) + 1;
                                            tip.comments.add(commentController.text);
                                          });
                                          // Send the comment to the server
                                          addComment(tip.id, commentController.text);
                                          // Clear the text field
                                          commentController.clear();
                                          // Dismiss the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Add Comment', style: TextStyle(color:  Color(0xFF731902))),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      Spacer(),
                      IconButton(onPressed: (){ }, icon: Icon(Icons.share, color:  Color(0xFF731902)),),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchTips extends StatefulWidget {
  @override
  _SearchTipsState createState() => _SearchTipsState();
}

class _SearchTipsState extends State<SearchTips> {
  TextEditingController _searchController = TextEditingController();
  List<Tips> _searchResults = [];
  Tips? _selectedTip;

  Future<void> _searchTips(String query) async {
    try {
      List<Tips> tips = await TipApiService.searchTips(query);
      setState(() {
        _searchResults = tips;
      });
    } catch (e) {
      print('Failed to search tips: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.blueGrey),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(double.infinity),
            ),
          ),
          style: TextStyle(color: Colors.black),
          onChanged: (value) {
            _searchTips(value);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchTips(_searchController.text);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final tip = _searchResults[index];
          return ListTile(
            title: Text(tip.title),
            leading: Image.network(tip.imageUrl),
            onTap: () {
              setState(() {
                _selectedTip = tip;
              });
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(tip.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      AlertDialog(
                        title: Text(
                          _selectedTip!.title,
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),
                        ),
                        content: Text(
                          _selectedTip!.description,
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(color:Colors.white),
                            ),
                          ),
                        ],
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
