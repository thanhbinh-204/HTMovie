// class UserModel {
//   final String? name;
//   final String? avatarUrl;
//   final String email;
//   final bool isVerified;
//   final String role;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   UserModel({
//     this.name,
//     this.avatarUrl,
//     required this.email,
//     required this.isVerified,
//     required this.role,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       name: json['name'],
//       avatarUrl: json['avatarUrl'],
//       email: json['email'],
//       isVerified: json['isVerified'],
//       role: json['role'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }


class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final String rank;
  final int points;
  final String role;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    required this.rank,
    required this.points,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      rank: json['rank'],
      points: json['points'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
