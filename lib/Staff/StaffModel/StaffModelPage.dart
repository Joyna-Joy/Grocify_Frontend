class Staff {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNo;
  final String role;

  Staff({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.role,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNo: json['phone_no'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone_no': phoneNo,
      'password': password,
      'role': role,
    };
  }
}
