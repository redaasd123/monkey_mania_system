class LoginModel {
  final int id;
  final String username;
  final String email;
  final String role;
  final String access;
  final String reFresh;

  LoginModel({
    required this.reFresh,
    required this.access,
    required this.role,
    required this.id,
    required this.username,
    required this.email,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};

    return LoginModel(
      reFresh: json['refresh.dart'] ?? '',
      access: json['access'] ?? '',
      role: user['role'] ?? '',
      id: user['id'] ?? 0,
      username: user['username'] ?? '',
      email: user['email'] ?? '',
    );
  }
}
