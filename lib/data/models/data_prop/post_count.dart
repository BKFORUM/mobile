class Count {
  int likes;
  int comments;

  Count({required this.likes, required this.comments});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      likes: json['likes'] ?? 0 ,
      comments: json['comments'] ?? 0,
    );
  }
}