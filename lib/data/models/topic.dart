class Topic {
  String id;
  String? name;

  Topic({
    required this.id,
    this.name,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['topic']['id'] ?? 'Default id',
      name: json['topic']['displayName'] ?? 'Default displayName',
    );
  }
}