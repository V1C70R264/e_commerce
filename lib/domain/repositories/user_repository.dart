import '../entities/user.dart';
import 'dart:io';

abstract class UserRepository {
  Future<User> getUserProfile();
  Future<User> updateProfileImage(File image);
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<bool> login({
    required String email,
    required String password,
  });
  // Add more as needed
}
