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
      avatarUrl: json['avatarUrl'] ?? 'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png',
      dateOfBirth: json['dateOfBirth'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}
