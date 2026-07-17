import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class RegisterUserUseCase {
  final AuthRepository authRepository;

  RegisterUserUseCase(this.authRepository);

  Future<Result<void>> call({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) {
    return authRepository.register(
      username: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
  }
}
