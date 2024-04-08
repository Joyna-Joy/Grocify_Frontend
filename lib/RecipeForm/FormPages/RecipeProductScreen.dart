import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormModel/RecipeProductModel.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/RecipeProductAdd.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/Recipe_Form.dart';
import 'package:grocify_frontend/RecipeForm/FormServices/RecipeProductServices.dart';


class RecipeProductView extends StatefulWidget {
  @override
  _RecipeProductViewState createState() => _RecipeProductViewState();
}

class _RecipeProductViewState extends State<RecipeProductView> {
  List<Recipeproduct> productList = []; // Use the new model class

  Map<String, bool> likedProduct = {};
  Map<String, int> commentsCount = {};
  TextEditingController commentController = TextEditingController();

  var productId;

  @override
  void initState() {
    super.initState();
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      List<Recipeproduct> products = await RecipeProductService.getAllProducts();
      setState(() {
        productList = products;
        // Initialize likedProduct map and commentsCount map with default values
        for (var product in productList) {
          likedProduct[product.id] = false;
          commentsCount[product.id] = 0;
        }
      });
    } catch (e) {
      print('Failed to load product: $e');
    }
  }

  void toggleLike(String productId) {
    setState(() {
      likedProduct[productId] = !likedProduct[productId]!;
    });
  }

  void addComment(String productId, String comment) {
    setState(() {
      // Check if the comment already exists in the list
      final product = productList.firstWhere((product) => product.id == productId);
      if (!product.comments.contains(commentController.text)) {
        // Increment comments count for the corresponding product
        commentsCount[productId] = (commentsCount[productId] ?? 0) + 1;
        // Add the comment to the comments list
        product.comments.add(commentController.text);
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
            Icon(Icons.shopping_cart, color: Color(0xFF731902)),
            SizedBox(width: 10),
            Text('Product Review', style: TextStyle(color: Color(0xFF731902))),
          ],
        ),
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeForm()));}, icon:Icon(Icons.arrow_back_ios_new,color:  Color(0xFF731902),)),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen())),
            icon: Icon(Icons.add_circle_rounded, color: Color(0xFF731902)),
          ),
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>SearchRecipeProduct() ));},icon: Icon(Icons.search, color:  Color(0xFF731902)),),

        ],
      ),
      body: productList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          final isLiked = likedProduct[product.id] ?? false;
          return Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.imageUrl != null)
                    Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 10),
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Price: ${product.price}', // Display the product price
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Category: ${product.category}', // Assuming category is part of Recipeproduct model
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Color(0xFFFF0000) : null,
                        ),
                        onPressed: () => toggleLike(product.id),
                      ),
                      IconButton(
                        icon: Icon(Icons.comment, color: Color(0xFF731902)),
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
                                        if (commentsCount[product.id] != null && commentsCount[product.id]! > 0)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: List.generate(
                                              commentsCount[product.id]!,
                                                  (index) => Text('Comment ${index + 1}: ${product.comments[index]}'),
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
                                            commentsCount[product.id] = (commentsCount[product.id] ?? 0) + 1;
                                            product.comments.add(commentController.text);
                                          });
                                          // Send the comment to the server
                                          addComment(product.id, commentController.text);
                                          // Clear the text field
                                          commentController.clear();
                                          // Dismiss the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Add Comment', style: TextStyle(color: Color(0xFF731902))),
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
                      IconButton(onPressed: () {}, icon: Icon(Icons.share, color: Color(0xFF731902))),
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


class SearchRecipeProduct extends StatefulWidget {
  @override
  _SearchRecipeProductState createState() => _SearchRecipeProductState();
}

class _SearchRecipeProductState extends State<SearchRecipeProduct> {
  TextEditingController _searchController = TextEditingController();
  List<Recipeproduct> _searchResults = [];
  Recipeproduct? _selectedProduct;

  Future<void> _searchRecipeProduct(String query) async {
    try {
      List<Recipeproduct> products = await RecipeProductService.searchProducts(query);
      setState(() {
        _searchResults = products;
      });
    } catch (e) {
      print('Failed to search products: $e');
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
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          style: TextStyle(color: Colors.black),
          onChanged: (value) {
            _searchRecipeProduct(value);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchRecipeProduct(_searchController.text);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          return ListTile(
            title: Text(product.name),
            leading: Image.network(product.imageUrl),
            onTap: () {
              setState(() {
                _selectedProduct = product;
              });
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
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
                          _selectedProduct!.name,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        content: Text(
                          _selectedProduct!.description,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
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