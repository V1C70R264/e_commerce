import '../../domain/repositories/user_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/remote/user_remote_datasource.dart';
import 'dart:io';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl(this.remoteDatasource);

  @override
  Future<User> getUserProfile() async {
    final userModel = await remoteDatasource.fetchUserProfile();
    return User(
      id: userModel.id.toString(),
      email: userModel.email,
      username: userModel.username,
      fullName: null, // Map as needed
      phoneNumber: userModel.phoneNumber,
      profileImage: userModel.profileImage,
      createdAt: DateTime.now(), // Map as needed
      updatedAt: DateTime.now(), // Map as needed
    );
  }

  @override
  Future<User> updateProfileImage(File image) async {
    // Implement this based on your API and UserRemoteDatasource
    throw UnimplementedError();
  }
}
