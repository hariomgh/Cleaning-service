import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest {
  final String fname;
  final String lname;
  final String email;
  final String otp;
  final String password;
  @JsonKey(name: 'confirm_password')
  final String confirmPassword;

  SignupRequest({
    required this.fname,
    required this.lname,
    required this.email,
    required this.otp,
    required this.password,
    required this.confirmPassword,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

