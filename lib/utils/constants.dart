class ApiConstants {
  // Base URL - Update this with your actual server URL
  static const String baseUrl = 'https://dev.shinehub.de/';

  // API Endpoints
  static const String sendOtpEndpoint = '/otp/send-otp';
  static const String signupEndpoint = '/auth/signup';
  static const String loginEndpoint = '/auth/login';
  static const String getUserEndpoint = '/auth/user';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  
  // Booking Endpoints
  static const String residentialBookingEndpoint = '/residential-booking/';
  static const String hourlyBookingEndpoint = '/hourly-booking/';
  static const String commercialBookingEndpoint = '/commercial-booking/';
  static const String homeOrganizationEndpoint = '/home-organization/';
  
  // Shared Preferences Keys
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String authTokenKey = 'auth_token';
}


