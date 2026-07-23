import '../../../../core/utils/result.dart';
import '../../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository authRepository;

  VerifyOtpUseCase(this.authRepository);

  Future<Result<void>> call({
    required String email,
    required String otp,
  }) async {
    return await authRepository.verifyOtp(email: email, otp: otp);
  }
}
