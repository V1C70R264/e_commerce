class UserModel {
  final int id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      profileImage: json['profile_image'] as String?,
    );
  }
}
