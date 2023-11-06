class Count {
  int likes;
  int comments;

  Count({required this.likes, required this.comments});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      likes: json['likes'] ?? 'Default like' ,
      comments: json['comments'] ?? 'Default comments',
    );
  }
}