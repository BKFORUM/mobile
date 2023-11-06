class Forum {
  String id;
  String name;
  String modId;
  String? avatarUrl;

  Forum({
    required this.id,
    required this.name,
    required this.modId,
    this.avatarUrl
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'] ?? 'Default id',
      name: json['name'] ?? 'Default name',
      modId: json['modId'] ?? 'Default modId',
      avatarUrl: json['avatarUrl'] ?? 'Default avatarUrl',
    );
  }
}
