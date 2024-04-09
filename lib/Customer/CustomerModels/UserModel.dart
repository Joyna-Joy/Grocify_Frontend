// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String name;
  String email;
  String password;
  String address;
  String phoneNo;
  String pincode;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNo,
    required this.pincode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    address: json["address"],
    phoneNo: json["phoneNo"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "address": address,
    "phoneNo": phoneNo,
    "pincode": pincode,
  };
}
