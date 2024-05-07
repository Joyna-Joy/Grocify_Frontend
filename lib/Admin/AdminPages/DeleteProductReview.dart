import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormModel/RecipeProductModel.dart';
import 'package:grocify_frontend/RecipeForm/FormServices/RecipeProductServices.dart';

class RecipeProductDeletePage extends StatefulWidget {
  @override
  _RecipeProductDeletePageState createState() => _RecipeProductDeletePageState();
}

class _RecipeProductDeletePageState extends State<RecipeProductDeletePage> {
  List<Recipeproduct> _productList = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final productList = await RecipeProductService.getAllProducts();
      setState(() {
        _productList = productList;
      });
    } catch (e) {
      print('Failed to load products: $e');
    }
  }

  Future<void> _deleteProduct(String recipeproductId) async {
    final productService = RecipeProductService();
    final response = await productService.deleteRecipeProduct(recipeproductId);
    print('Response: $response');
    if (response.containsKey('deletedProduct')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully'), backgroundColor: Colors.green,),
      );
      // Remove the deleted item from the list
      setState(() {
        _productList.removeWhere((recipeproduct) => recipeproduct.id == recipeproductId);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product'), backgroundColor: Colors.red,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF540D35),
        title: Text('Recipe Products', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: _productList.length,
        itemBuilder: (context, index) {
          final product = _productList[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () => _deleteProduct(product.id),
            ),
          );
        },
      ),
    );
  }
}
