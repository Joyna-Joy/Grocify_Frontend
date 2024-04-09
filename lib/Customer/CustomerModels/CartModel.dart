class Cart {
  String id;
  String userId;
  List<CartItem> cartItems;

  Cart({
    required this.id,
    required this.userId,
    required this.cartItems,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<dynamic>? cartItemsList = json['cartItems'];
    List<CartItem> parsedCartItems = cartItemsList != null
        ? List<CartItem>.from(cartItemsList.map((item) => CartItem.fromJson(item)))
        : [];

    return Cart(
      id: json['_id'],
      userId: json['user_id'],
      cartItems: parsedCartItems,
    );
  }
}

class CartItem {
  String productId;
  int quantity;
  double price;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }
}
