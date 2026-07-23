import '../../../../core/utils/result.dart';
import '../../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  Future<Result<void>> call({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    return await authRepository.confirmPasswordReset(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
  }
}
