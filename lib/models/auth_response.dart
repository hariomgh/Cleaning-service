import 'user_model.dart';

class AuthResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? result;
  
  // Helper getters to access nested data
  UserModel? get user {
    if (result != null && result!.containsKey('user')) {
      return UserModel.fromJson(result!['user'] as Map<String, dynamic>);
    }
    return null;
  }

  String? get token {
    if (result != null && result!.containsKey('token')) {
      return result!['token'] as String;
    }
    return null;
  }

  String? get userId => user?.id;

  AuthResponse({
    required this.success,
    required this.message,
    this.result,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      result: json['result'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'result': result,
    };
  }
}

