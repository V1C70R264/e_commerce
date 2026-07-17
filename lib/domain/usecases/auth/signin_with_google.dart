import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<Result<User>> call() {
    return repository.signInWithGoogle();
  }
}
