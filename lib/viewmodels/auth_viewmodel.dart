import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/signup_request.dart';
import '../models/login_request.dart';
import '../repositories/auth_repository.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error,
}

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final SharedPreferences _prefs;

  AuthViewModel({
    AuthRepository? authRepository,
    required SharedPreferences prefs,
  })  : _authRepository = authRepository ?? AuthRepository(),
        _prefs = prefs {
    _checkTokenExpiration();
  }

  // OTP State
  AuthStatus _otpStatus = AuthStatus.initial;
  String? _otpMessage;
  String? _otpCode;
  String? _errorMessage;

  // User State
  AuthStatus _userStatus = AuthStatus.initial;
  UserModel? _currentUser;

  // Auth State (for login/signup)
  AuthStatus _authStatus = AuthStatus.initial;
  String? _authToken;

  // Getters
  AuthStatus get otpStatus => _otpStatus;
  String? get otpMessage => _otpMessage;
  String? get otpCode => _otpCode;
  String? get errorMessage => _errorMessage;
  AuthStatus get userStatus => _userStatus;
  UserModel? get currentUser => _currentUser;
  AuthStatus get authStatus => _authStatus;
  String? get authToken => _authToken;

  bool get isOtpLoading => _otpStatus == AuthStatus.loading;
  bool get isUserLoading => _userStatus == AuthStatus.loading;
  bool get isAuthLoading => _authStatus == AuthStatus.loading;

  /// Send OTP to email
  Future<bool> sendOtp(String email) async {
    print('📱 AuthViewModel: sendOtp called with email: $email');
    try {
      print('📱 AuthViewModel: Setting OTP status to loading');
      _otpStatus = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      print('📱 AuthViewModel: Calling repository to send OTP');
      final response = await _authRepository.sendOtp(email);
      
      print('📱 AuthViewModel: OTP sent successfully');
      _otpStatus = AuthStatus.success;
      _otpMessage = response.message;
      _otpCode = response.otp;
      _errorMessage = null;
      
      print('📱 AuthViewModel: Saving email to SharedPreferences');
      // Save email for later use
      await _prefs.setString(ApiConstants.userEmailKey, email);
      print('📱 AuthViewModel: Email saved: $email');
      
      print('📱 AuthViewModel: Notifying listeners of success');
      notifyListeners();
      print('📱 AuthViewModel: sendOtp completed successfully');
      return true;
    } catch (e) {
      print('📱 AuthViewModel: ❌ Error in sendOtp: ${e.toString()}');
      _otpStatus = AuthStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _otpMessage = null;
      _otpCode = null;
      print('📱 AuthViewModel: Setting error message: $_errorMessage');
      notifyListeners();
      return false;
    }
  }

  /// Sign up a new user
  Future<bool> signup(SignupRequest request) async {
    print('📱 AuthViewModel: signup called with email: ${request.email}');
    try {
      print('📱 AuthViewModel: Setting auth status to loading');
      _authStatus = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      print('📱 AuthViewModel: Calling repository to signup');
      final response = await _authRepository.signup(request);
      
      if (response.success) {
        print('📱 AuthViewModel: Signup successful');
        _authStatus = AuthStatus.success;
        _errorMessage = null;
        
        // Save user data
        if (response.user != null) {
          _currentUser = response.user;
        }
        
        // Save user ID and token
        if (response.userId != null) {
          print('📱 AuthViewModel: Saving userId to SharedPreferences');
          await _prefs.setString(ApiConstants.userIdKey, response.userId!);
          print('📱 AuthViewModel: UserId saved: ${response.userId}');
        }
        
        if (response.token != null) {
          print('📱 AuthViewModel: Saving auth token to SharedPreferences');
          _authToken = response.token;
          await _prefs.setString(ApiConstants.authTokenKey, response.token!);
          print('📱 AuthViewModel: Token saved');
        }
        
        // Save email
        print('📱 AuthViewModel: Saving email to SharedPreferences');
        await _prefs.setString(ApiConstants.userEmailKey, request.email);
        print('📱 AuthViewModel: Email saved: ${request.email}');
        
        print('📱 AuthViewModel: Notifying listeners of success');
        notifyListeners();
        print('📱 AuthViewModel: signup completed successfully');
        return true;
      } else {
        print('📱 AuthViewModel: Signup failed: ${response.message}');
        _authStatus = AuthStatus.error;
        _errorMessage = response.message;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('📱 AuthViewModel: ❌ Error in signup: ${e.toString()}');
      _authStatus = AuthStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      print('📱 AuthViewModel: Setting error message: $_errorMessage');
      notifyListeners();
      return false;
    }
  }

  /// Login user
  Future<bool> login(LoginRequest request) async {
    print('📱 AuthViewModel: login called with email: ${request.email}');
    try {
      print('📱 AuthViewModel: Setting auth status to loading');
      _authStatus = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      print('📱 AuthViewModel: Calling repository to login');
      final response = await _authRepository.login(request);
      
      if (response.success) {
        print('📱 AuthViewModel: Login successful');
        _authStatus = AuthStatus.success;
        _errorMessage = null;
        
        // Save user data
        if (response.user != null) {
          _currentUser = response.user;
        }
        
        // Save user ID and token
        if (response.userId != null) {
          print('📱 AuthViewModel: Saving userId to SharedPreferences');
          await _prefs.setString(ApiConstants.userIdKey, response.userId!);
          print('📱 AuthViewModel: UserId saved: ${response.userId}');
        }
        
        if (response.token != null) {
          print('📱 AuthViewModel: Saving auth token to SharedPreferences');
          _authToken = response.token;
          await _prefs.setString(ApiConstants.authTokenKey, response.token!);
          print('📱 AuthViewModel: Token saved');
        }
        
        // Save email
        print('📱 AuthViewModel: Saving email to SharedPreferences');
        await _prefs.setString(ApiConstants.userEmailKey, request.email);
        print('📱 AuthViewModel: Email saved: ${request.email}');
        
        print('📱 AuthViewModel: Notifying listeners of success');
        notifyListeners();
        print('📱 AuthViewModel: login completed successfully');
        return true;
      } else {
        print('📱 AuthViewModel: Login failed: ${response.message}');
        _authStatus = AuthStatus.error;
        _errorMessage = response.message;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('📱 AuthViewModel: ❌ Error in login: ${e.toString()}');
      _authStatus = AuthStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      print('📱 AuthViewModel: Setting error message: $_errorMessage');
      notifyListeners();
      return false;
    }
  }

  /// Get user data by ID
  Future<bool> getUserData(String userId) async {
    print('📱 AuthViewModel: getUserData called with userId: $userId');
    try {
      print('📱 AuthViewModel: Setting user status to loading');
      _userStatus = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      print('📱 AuthViewModel: Calling repository to get user data');
      final user = await _authRepository.getUserData(userId);
      
      print('📱 AuthViewModel: User data fetched successfully');
      _currentUser = user;
      _userStatus = AuthStatus.success;
      _errorMessage = null;
      
      print('📱 AuthViewModel: Saving userId to SharedPreferences');
      // Save user ID
      await _prefs.setString(ApiConstants.userIdKey, userId);
      print('📱 AuthViewModel: UserId saved: $userId');
      
      print('📱 AuthViewModel: Notifying listeners of success');
      notifyListeners();
      print('📱 AuthViewModel: getUserData completed successfully');
      return true;
    } catch (e) {
      print('📱 AuthViewModel: ❌ Error in getUserData: ${e.toString()}');
      _userStatus = AuthStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      print('📱 AuthViewModel: Setting error message: $_errorMessage');
      notifyListeners();
      return false;
    }
  }

  /// Clear OTP state
  void clearOtpState() {
    _otpStatus = AuthStatus.initial;
    _otpMessage = null;
    _otpCode = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear user state
  void clearUserState() {
    _userStatus = AuthStatus.initial;
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Get saved user ID
  String? getSavedUserId() {
    return _prefs.getString(ApiConstants.userIdKey);
  }

  /// Get saved email
  String? getSavedEmail() {
    return _prefs.getString(ApiConstants.userEmailKey);
  }

  /// Logout - clear all saved data
  Future<void> logout() async {
    print('📱 AuthViewModel: logout called');
    print('📱 AuthViewModel: Removing userId from SharedPreferences');
    await _prefs.remove(ApiConstants.userIdKey);
    print('📱 AuthViewModel: Removing userEmail from SharedPreferences');
    await _prefs.remove(ApiConstants.userEmailKey);
    print('📱 AuthViewModel: Removing authToken from SharedPreferences');
    await _prefs.remove(ApiConstants.authTokenKey);
    print('📱 AuthViewModel: Clearing OTP state');
    clearOtpState();
    print('📱 AuthViewModel: Clearing user state');
    clearUserState();
    print('📱 AuthViewModel: Logout completed');
  }

  /// Forgot Password
  Future<bool> forgotPassword(String email) async {
    print('📱 AuthViewModel: forgotPassword called with email: $email');
    try {
      print('📱 AuthViewModel: Setting auth status to loading');
      _authStatus = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      print('📱 AuthViewModel: Calling repository for forgot password');
      await _authRepository.forgotPassword(email);
      
      print('📱 AuthViewModel: Forgot password request successful');
      _authStatus = AuthStatus.success;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      print('📱 AuthViewModel: ❌ Error in forgotPassword: ${e.toString()}');
      _authStatus = AuthStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  /// Reset Password
  Future<bool> resetPassword(String email, String otp, String newPassword) async {
    print('📱 AuthViewModel: resetPassword called with email: $email');
    try {
      print('📱 AuthViewModel: Setting auth status to loading');
      _authStatus = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      print('📱 AuthViewModel: Calling repository for reset password');
      await _authRepository.resetPassword(email, otp, newPassword);
      
      print('📱 AuthViewModel: Reset password successful');
      _authStatus = AuthStatus.success;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      print('📱 AuthViewModel: ❌ Error in resetPassword: ${e.toString()}');
      _authStatus = AuthStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  /// Check if token is expired
  void _checkTokenExpiration() {
    final token = _prefs.getString(ApiConstants.authTokenKey);
    if (token != null) {
      if (_isTokenExpired(token)) {
        print('📱 AuthViewModel: Token expired, logging out');
        logout();
      } else {
        print('📱 AuthViewModel: Token valid');
        _authToken = token;
      }
    }
  }

  /// Helper to check token expiration
  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return true;
      }
      
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final resp = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(resp);
      
      if (payloadMap is Map<String, dynamic> && payloadMap.containsKey('exp')) {
        final exp = payloadMap['exp'];
        if (exp is int) {
          final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
          return DateTime.now().isAfter(expiryDate);
        }
      }
      return true; // If no exp claim, assume expired or invalid for this purpose
    } catch (e) {
      print('📱 AuthViewModel: Error checking token expiration: $e');
      return true;
    }
  }
}

