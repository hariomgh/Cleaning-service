class ApiConstants {
  // Base URL - Update this with your actual server URL
  static const String baseUrl = 'http://212.132.99.95:8081/';

  // API Endpoints
  static const String sendOtpEndpoint = '/otp/send-otp';
  static const String signupEndpoint = '/auth/signup';
  static const String loginEndpoint = '/auth/login';
  static const String getUserEndpoint = '/auth/user';
  static const String forgotPasswordEndpoint = '/auth//forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  
  // Shared Preferences Keys
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String authTokenKey = 'auth_token';
}


