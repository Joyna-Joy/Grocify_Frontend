class Order {
  String id;
  ShippingInfo shippingInfo;
  List<OrderItem> orderItems;
  String userId;
  PaymentInfo paymentInfo;
  DateTime paidAt;
  double totalPrice;
  String orderStatus;
  DateTime? deliveredAt;
  DateTime? shippedAt;
  DateTime createdAt;

  Order({
    required this.id,
    required this.shippingInfo,
    required this.orderItems,
    required this.userId,
    required this.paymentInfo,
    required this.paidAt,
    required this.totalPrice,
    required this.orderStatus,
    this.deliveredAt,
    this.shippedAt,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      shippingInfo: ShippingInfo.fromJson(json['shippingInfo']),
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      userId: json['user_id'],
      paymentInfo: PaymentInfo.fromJson(json['paymentInfo']),
      paidAt: DateTime.parse(json['paidAt']),
      totalPrice: json['totalPrice'].toDouble(),
      orderStatus: json['orderStatus'],
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      shippedAt: json['shippedAt'] != null
          ? DateTime.parse(json['shippedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ShippingInfo {
  String address;
  String city;
  String state;
  String country;
  int pincode;
  int phoneNo;

  ShippingInfo({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.phoneNo,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      phoneNo: json['phoneNo'],
    );
  }
}

class OrderItem {
  String name;
  double price;
  int quantity;
  String image;
  String productId;

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.productId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      image: json['image'],
      productId: json['product_id'],
    );
  }
}

class PaymentInfo {
  String id;
  String status;

  PaymentInfo({
    required this.id,
    required this.status,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      id: json['id'],
      status: json['status'],
    );
  }
}
