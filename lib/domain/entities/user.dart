class User {
  final String id;
  final String email;
  final String? username;
  final String? fullName;
  final String? phoneNumber;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, fullName: $fullName}';
  }
} 