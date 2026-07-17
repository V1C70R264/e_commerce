class ApiPaths {
  // Authentication endpoints
  static const login = '/auth/login/';
  static const logout = '/auth/logout/';
  static const register = '/auth/register/';
  static const googlesignin = '/auth/google/';
  static const tokenRefresh = '/auth/token/refresh/';
  // Profile endpoints
  static const profile = '/profile/';
  static const changePassword = '/profile/change-password/';
  // Password Management endpoints
  static const confirmPasswordReset = '/password/confirm/';
  static const requestPasswordReset = '/password/request/';
  static const validateResetToken = '/password/validate/';
  static const requestOtpRequest = '/password/otp/request/';
  static const confirmOtpRequest = '/password/otp/confirm/';
}
