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
      fullName: _buildFullName(userModel.firstName, userModel.lastName),
      phoneNumber: userModel.phoneNumber,
      profileImage: userModel.profileImage,
      createdAt: DateTime.now(), // Map as needed or parse from API if provided
      updatedAt: DateTime.now(), // Map as needed or parse from API if provided
    );
  }

  String? _buildFullName(String? first, String? last) {
    final f = (first ?? '').trim();
    final l = (last ?? '').trim();
    if (f.isEmpty && l.isEmpty) return null;
    if (f.isEmpty) return l;
    if (l.isEmpty) return f;
    return '$f $l';
  }

  @override
  Future<User> updateProfileImage(File image) async {
    // Implement this based on your API and UserRemoteDatasource
    throw UnimplementedError();
  }

  @override
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return remoteDatasource.register(
      username: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    return remoteDatasource.login(email: email, password: password);
  }
}
