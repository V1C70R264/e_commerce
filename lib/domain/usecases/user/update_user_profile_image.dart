import '../../entities/user.dart';
import '../../repositories/user_repository.dart';
import 'dart:io';

class UpdateUserProfileImage {
  final UserRepository repository;
  UpdateUserProfileImage(this.repository);

  Future<User> call(File image) => repository.updateProfileImage(image);
}
