import 'package:e_commerce/core/config/api_config.dart';

class UserModel {
  final int id;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse('${json['id']}') ?? 0,
      username: json['username']  as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name']  as String?,
      phoneNumber: json['phone'] as String?,
      profileImage: _resolveImageUrl(json['avatar_url']),
    );
  }

  static String? _resolveImageUrl(dynamic value) {
    if (value == null) return null;
    final url = value.toString().trim();
    if (url.isEmpty) return null;
    if (url.startsWith('http://') || url.startsWith('https://')) return url;

    final apiBase = ApiConfig.baseUrl.replaceAll(RegExp(r'/+$'), '');
    final origin = apiBase.replaceAll(RegExp(r'/api/v1$'), '');
    return url.startsWith('/') ? '$origin$url' : '$origin/$url';
  }
}
