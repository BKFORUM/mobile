class Forum {
  String id;
  String name;
  String? modId;
  String modName;
  String? avatarUrl;

  Forum({
    required this.id,
    required this.name,
    this.modId,
    required this.modName,
    this.avatarUrl
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'] ?? 'Default id',
      name: json['name'] ?? 'Default name',
      modId: json['modId'] ?? 'Default modId',
      modName: 'moderator name',
      avatarUrl: json['avatarUrl'] ?? 'Default avatarUrl',
    );
  }
}
