import '../../repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;
  RegisterUser(this.repository);

  Future<bool> call({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return repository.register(
      username: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
