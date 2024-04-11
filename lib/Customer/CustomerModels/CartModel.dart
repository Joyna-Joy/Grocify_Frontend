import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  Cart cart = Cart(userId: '', id: '', cartItems: []);
  double totalCartValue = 0;

  int get total => cart.cartItems.length;

  void addProduct(product) {
    int index = cart.cartItems.indexWhere((i) => i.productId == product.productId);
    if (index != -1)
      updateProduct(product, product.quantity + 1);
    else {
      cart.cartItems.add(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.cartItems.indexWhere((i) => i.productId == product.productId);
    cart.cartItems[index].quantity = 1;
    cart.cartItems.removeWhere((item) => item.productId == product.productId);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.cartItems.indexWhere((i) => i.productId == product.productId);
    cart.cartItems[index].quantity = qty;
    if (cart.cartItems[index].quantity == 0)
      removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.cartItems.forEach((f) => f.quantity = 1);
    cart.cartItems = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.cartItems.forEach((f) {
      totalCartValue += f.price * f.quantity;
    });
  }
}

class Cart {
  String id;
  String userId;
  List<CartItem> cartItems;

  Cart({
    required this.id,
    required this.userId,
    required this.cartItems,
  });
}

class CartItem {
  String productId;
  int quantity;
  double price;
  String title; // Add this property assuming you need it in your UI

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.title,
  });
}
