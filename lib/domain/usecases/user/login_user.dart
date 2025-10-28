import '../../repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;
  LoginUser(this.repository);

  Future<bool> call({
    required String email,
    required String password,
  }) async {
    return repository.login(email: email, password: password);
  }
}
