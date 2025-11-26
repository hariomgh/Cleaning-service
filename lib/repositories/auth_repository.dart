import '../models/otp_request.dart';
import '../models/otp_response.dart';
import '../models/user_model.dart';
import '../models/signup_request.dart';
import '../models/login_request.dart';
import '../models/auth_response.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  /// Send OTP to the specified email address
  Future<OtpResponse> sendOtp(String email) async {
    print('🔐 AuthRepository: Sending OTP to email: $email');
    try {
      final request = OtpRequest(email: email);
      print('🔐 AuthRepository: Request object created: ${request.toJson()}');
      
      final response = await apiService.post(
        ApiConstants.sendOtpEndpoint,
        request.toJson(),
      );
      
      print('🔐 AuthRepository: API response received, parsing to OtpResponse');
      final otpResponse = OtpResponse.fromJson(response);
      print('🔐 AuthRepository: OTP Response parsed successfully');
      print('   - Success: ${otpResponse.success}');
      print('   - Message: ${otpResponse.message}');
      print('   - OTP: ${otpResponse.otp}');
      
      return otpResponse;
    } catch (e) {
      print('🔐 AuthRepository: ❌ Error sending OTP: ${e.toString()}');
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

  /// Sign up a new user
  Future<AuthResponse> signup(SignupRequest request) async {
    print('🔐 AuthRepository: Signing up user with email: ${request.email}');
    try {
      print('🔐 AuthRepository: Signup request object created: ${request.toJson()}');
      
      final response = await apiService.post(
        ApiConstants.signupEndpoint,
        request.toJson(),
      );
      
      print('🔐 AuthRepository: API response received, parsing to AuthResponse');
      final authResponse = AuthResponse.fromJson(response);
      print('🔐 AuthRepository: AuthResponse parsed successfully');
      print('   - Success: ${authResponse.success}');
      print('   - Message: ${authResponse.message}');
      print('   - User ID: ${authResponse.userId ?? "N/A"}');
      print('   - Token: ${authResponse.token != null ? "Present" : "N/A"}');
      
      return authResponse;
    } catch (e) {
      print('🔐 AuthRepository: ❌ Error signing up: ${e.toString()}');
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  /// Login user
  Future<AuthResponse> login(LoginRequest request) async {
    print('🔐 AuthRepository: Logging in user with email: ${request.email}');
    try {
      print('🔐 AuthRepository: Login request object created: ${request.toJson()}');
      
      final response = await apiService.post(
        ApiConstants.loginEndpoint,
        request.toJson(),
      );
      
      print('🔐 AuthRepository: API response received, parsing to AuthResponse');
      final authResponse = AuthResponse.fromJson(response);
      print('🔐 AuthRepository: AuthResponse parsed successfully');
      print('   - Success: ${authResponse.success}');
      print('   - Message: ${authResponse.message}');
      print('   - User ID: ${authResponse.userId ?? "N/A"}');
      print('   - Token: ${authResponse.token != null ? "Present" : "N/A"}');
      
      return authResponse;
    } catch (e) {
      print('🔐 AuthRepository: ❌ Error logging in: ${e.toString()}');
      throw Exception('Failed to login: ${e.toString()}');
    }
  }

  /// Get user data by user ID
  Future<UserModel> getUserData(String userId) async {
    print('👤 AuthRepository: Fetching user data for userId: $userId');
    try {
      final endpoint = '${ApiConstants.getUserEndpoint}/$userId';
      print('👤 AuthRepository: Endpoint: $endpoint');
      
      final response = await apiService.get(endpoint);
      
      print('👤 AuthRepository: API response received, parsing to UserModel');
      final userModel = UserModel.fromJson(response);
      print('👤 AuthRepository: UserModel parsed successfully');
      print('   - User ID: ${userModel.id}');
      print('   - Email: ${userModel.email ?? "N/A"}');
      print('   - Name: ${userModel.name ?? "N/A"}');
      print('   - Phone: ${userModel.phone ?? "N/A"}');
      
      return userModel;
    } catch (e) {
      print('👤 AuthRepository: ❌ Error getting user data: ${e.toString()}');
      throw Exception('Failed to get user data: ${e.toString()}');
    }
  }

  /// Forgot password - send OTP
  Future<bool> forgotPassword(String email) async {
    print('🔐 AuthRepository: Requesting password reset for email: $email');
    try {
      // Note: API expects 'mail' key instead of 'email' for this specific endpoint
      final body = {'mail': email};
      print('🔐 AuthRepository: Request body: $body');
      
      final response = await apiService.post(
        ApiConstants.forgotPasswordEndpoint,
        body,
      );
      
      print('🔐 AuthRepository: Forgot password response received');
      return true;
    } catch (e) {
      print('🔐 AuthRepository: ❌ Error in forgot password: ${e.toString()}');
      throw Exception('Failed to request password reset: ${e.toString()}');
    }
  }

  /// Reset password with OTP
  Future<bool> resetPassword(String email, String otp, String newPassword) async {
    print('🔐 AuthRepository: Resetting password for email: $email');
    try {
      final body = {
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      };
      print('🔐 AuthRepository: Request body created');
      
      final response = await apiService.post(
        ApiConstants.resetPasswordEndpoint,
        body,
      );
      
      print('🔐 AuthRepository: Reset password response received');
      return true;
    } catch (e) {
      print('🔐 AuthRepository: ❌ Error in reset password: ${e.toString()}');
      throw Exception('Failed to reset password: ${e.toString()}');
    }
  }
}


