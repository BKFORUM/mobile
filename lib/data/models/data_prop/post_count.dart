class Count {
  int? likes;
  int? comments;
  int? users;

  Count({this.likes, this.comments, this.users});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      likes: json['likes'] ?? 0 ,
      comments: json['comments'] ?? 0,
      users: json['users'] ?? 0,
    );
  }
}