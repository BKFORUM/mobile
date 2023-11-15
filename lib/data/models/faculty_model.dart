class Faculty {
  String id;
  String name;

  Faculty({
    required this.id,
    required this.name,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['id'],
      name: json['name'],
    );
  }
}