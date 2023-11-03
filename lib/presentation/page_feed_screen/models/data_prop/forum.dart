class Forum {
  String id;
  String name;
  String modId;
  String avatarUrl;

  Forum({required this.id, required this.name, required this.modId, required this.avatarUrl});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'],
      name: json['name'],
      modId: json['modId'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
