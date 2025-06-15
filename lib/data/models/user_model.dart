class User {
  final int? id;
  final String? name;
  final String email;
  final String? password;

  User({this.id, this.name, required this.email, this.password});

  // Desserialização
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) data['id'] = id;
    if (name != null && name!.isNotEmpty) data['name'] = name;
    if (email.isNotEmpty) data['email'] = email;
    if (password != null && password!.isNotEmpty) data['password'] = password;

    return data;
  }
}
