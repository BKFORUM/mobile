class User {
  String? id;
  String? avatarUrl;
  String? fullName;

  User({this.id, this.avatarUrl, this.fullName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 'default',
      avatarUrl: json['avatarUrl'] ?? 'default',
      fullName: json['fullName'] ?? 'default',
    );
  }
}