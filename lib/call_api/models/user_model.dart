class UserModel {
  final String id;
  final String? name;
  final String? avatarUrl;
  final String email;
  final bool isVerified;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    this.name,
    this.avatarUrl,
    required this.email,
    required this.isVerified,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      email: json['email'],
      isVerified: json['isVerified'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
