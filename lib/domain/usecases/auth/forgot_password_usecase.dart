import '../../../../core/utils/result.dart';
import '../../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  Future<Result<void>> call(String email) async {
    return await authRepository.forgotPassword(email);
  }
}
