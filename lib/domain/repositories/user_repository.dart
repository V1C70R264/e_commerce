import '../entities/user.dart';
import 'dart:io';

abstract class UserRepository {
  Future<User> getUserProfile();
  Future<User> updateProfileImage(File image);
}
