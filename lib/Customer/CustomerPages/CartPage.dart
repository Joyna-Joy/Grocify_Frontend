import 'package:flutter/material.dart';
import 'package:grocify_frontend/Customer/CustomerModels/CartModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Cart"),
        actions: <Widget>[
          TextButton(
            onPressed: () => ScopedModel.of<CartModel>(context).clearCart(),
            child: Text(
              "Clear",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ScopedModel.of<CartModel>(context, rebuildOnChange: true).cart.cartItems.length == 0
          ? Center(
        child: Text("No items in Cart"),
      )
          : Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: ScopedModel.of<CartModel>(context, rebuildOnChange: true).total,
                itemBuilder: (context, index) {
                  return ScopedModelDescendant<CartModel>(
                    builder: (context, child, model) {
                      return ListTile(
                        title: Text(model.cart.cartItems[index].title),
                        subtitle: Text(
                          model.cart.cartItems[index].quantity.toString() +
                              " x " +
                              model.cart.cartItems[index].price.toString() +
                              " = " +
                              (model.cart.cartItems[index].quantity * model.cart.cartItems[index].price).toString(),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                model.updateProduct(
                                  model.cart.cartItems[index],
                                  model.cart.cartItems[index].quantity + 1,
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                model.updateProduct(
                                  model.cart.cartItems[index],
                                  model.cart.cartItems[index].quantity - 1,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Total: \$ " +
                    ScopedModel.of<CartModel>(context, rebuildOnChange: true).totalCartValue.toString() +
                    "",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow[900]!),
                ),
                onPressed: () {},
                child: Text("BUY NOW"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
