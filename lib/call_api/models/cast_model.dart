class CastModel {
  final String id;
  final String name;
  final String? profileUrl;

  CastModel({required this.id, required this.name, required this.profileUrl});

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
    );
  }
}
