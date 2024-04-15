import 'package:flutter/material.dart';
import 'package:grocify_frontend/RecipeForm/FormModel/TipsModel.dart';
import 'package:grocify_frontend/RecipeForm/FormServices/TipService.dart';

class TipsDeletePage extends StatefulWidget {
  @override
  _TipsDeletePageState createState() => _TipsDeletePageState();
}

class _TipsDeletePageState extends State<TipsDeletePage> {
  List<Tips> _tips = [];

  @override
  void initState() {
    super.initState();
    _loadTips();
  }

  Future<void> _loadTips() async {
    try {
      final tips = await TipApiService.getAllTips();
      setState(() {
        _tips = tips;
      });
    } catch (e) {
      print('Failed to load tips: $e');
    }
  }

  Future<void> _deleteTip(String tipId) async {
      final response = await TipApiService().deleteTip(tipId); // Call deleteTip using an instance of TipApiService
      print('Response: $response');
      if (response['message'] == 'Tip deleted successfully') {
        // Tip deleted successfully, show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tip deleted successfully'),backgroundColor: Colors.green,),
        );
        // Reload tips after deletion
        _loadTips();
      } else {
        // Failed to delete tip, show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete tip'),backgroundColor: Colors.red,),
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
            Icon(Icons.restaurant_menu_rounded,color:Colors.white,),
            SizedBox(
              width: 10,
            ),
            Text('Tips & Tricks',style: TextStyle(color:Colors.white),),
          ],
        ),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
      ),
      body: ListView.builder(
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          final tip = _tips[index];
          return ListTile(
            leading: Image.network(tip.imageUrl),
            title: Text(tip.title),
            subtitle: Text(tip.author),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever,color: Colors.red,),
              onPressed: () => _deleteTip(tip.id),
            ),
          );
        },
      ),
    );
  }
}
