import '../entities/user.dart';
import '../../core/utils/result.dart';

abstract class AuthRepository {
  Future<Result<User>> login(String email, String password);
  Future<Result<User>> register(String email, String password, String username);
  Future<Result<void>> logout();
  Future<Result<User?>> getCurrentUser();
  Future<Result<void>> forgotPassword(String email);
} 