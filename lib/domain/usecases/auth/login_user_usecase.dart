import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class LoginUserUseCase {
  final AuthRepository authRepository;

  LoginUserUseCase(this.authRepository);

  Future<Result<User>> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
} 