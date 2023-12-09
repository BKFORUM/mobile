class User {
  String? id;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? avatarUrl;
  String? dateOfBirth;
  String? email;
  String? gender;

  User({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
    this.dateOfBirth,
    this.email,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}
