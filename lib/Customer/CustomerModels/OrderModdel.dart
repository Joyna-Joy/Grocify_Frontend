import 'package:grocify_frontend/Customer/CustomerModels/ProductModel.dart';

class Order {
  final String id;
  final ShippingInfo shippingInfo;
  final List<OrderItem> orderItems;
  final String userId;
  final PaymentInfo paymentInfo;
  final DateTime paidAt;
  final double totalPrice;
  final String orderStatus;
  final DateTime? deliveredAt;
  final DateTime? shippedAt;
  final DateTime createdAt;

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
      id: json['id'] ?? '',
      shippingInfo: ShippingInfo.fromJson(json['shippingInfo'] ?? {}),
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ??
          [],
      userId: json['user_id'] ?? '',
      paymentInfo: PaymentInfo.fromJson(json['paymentInfo'] ?? {}),
      paidAt: DateTime.parse(json['paidAt'] ?? ''),
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
      orderStatus: json['orderStatus'] ?? '',
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      shippedAt: json['shippedAt'] != null
          ? DateTime.parse(json['shippedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
    );
  }
}

class ShippingInfo {
  final String address;
  final String city;
  final String state;
  final String country;
  final int pincode;
  final int phoneNo;

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
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      pincode: json['pincode'] ?? 0,
      phoneNo: json['phoneNo'] ?? 0,
    );
  }
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: Product.fromJson(json['product'] ?? {}), // Update the key to match the JSON structure
      quantity: json['quantity'] ?? 0,
    );
  }
}


class PaymentInfo {
  final String id;
  final String status;

  PaymentInfo({
    required this.id,
    required this.status,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
    );
  }
}



class Product {
  final String id;
  final String productName;
  final String title;
  final String images;
  final String price;


  Product({
    required this.id,
    required this.productName,
    required this.title,
    required this.images,
    required this.price,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productName: json['product_name'],
      title: json['title'],
      images: json['images'],
      price: json['price'],

    );
  }

  toJson() {}
}

