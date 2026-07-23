import '../../../../core/utils/result.dart';

import '../entities/user.dart';



abstract class AuthRepository {

  Future<Result<User>> login(

    String email,

    String password,

  );



  Future<Result<void>> register({

    required String username,

    required String email,

    required String password,

    required String firstName,

    required String lastName,

    String? phoneNumber,

  });



  Future<Result<User>> signInWithGoogle();



  Future<Result<void>> logout();



  Future<Result<User?>> getCurrentUser();



  Future<Result<void>> forgotPassword(

    String email,

  );



  Future<Result<void>> verifyOtp({

    required String email,

    required String otp,

  });



  Future<Result<void>> confirmPasswordReset({

    required String email,

    required String otp,

    required String newPassword,

  });

}
