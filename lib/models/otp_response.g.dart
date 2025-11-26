// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) => OtpResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$OtpResponseToJson(OtpResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otp': instance.otp,
    };
