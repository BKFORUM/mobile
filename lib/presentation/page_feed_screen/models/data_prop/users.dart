class User {
  String id;
  String avatarUrl;
  String fullName;

  User({required this.id, required this.avatarUrl, required this.fullName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      fullName: json['fullName'],
    );
  }
}