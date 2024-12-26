class User {
  final String? name;
  final String? email;
  final String? password;
  final String? username;
  final String? token;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    this.token,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      username: json['username'],
      token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'username': username,
    };
  }
}
