class User {
  final int? id;
  final String nome;
  final String email;
  final String? senha;

  User({this.id, required this.nome, required this.email, this.senha});

  // Desserialização
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }

  factory User.fromJsonWithoutImage(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }

  // Serialização
  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'email': email, 'senha': senha};
  }
}
