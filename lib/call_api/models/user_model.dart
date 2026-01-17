class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;

  final String? rank;
  final int? points;
  final String? role;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.rank,
    this.points,
    this.role,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name']?.toString() ?? json['email']?.toString() ?? 'User',
      avatarUrl: json['avatarUrl'],
      rank: json['rank'],
      points: json['points'],
      role: json['role'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
