import 'package:json_annotation/json_annotation.dart';

part 'commercial_booking_model.g.dart';

@JsonSerializable()
class CommercialBookingRequest {
  final String userId;
  final String businessType;
  final String businessName;
  final double? squareFootage;
  final String date;
  final String time;
  final String address;
  final bool afterHours;
  final String frequency; // 'one-time', 'weekly', 'bi-weekly', 'monthly'
  final String? specialRequirements;
  final String paymentMethod;
  final double? estimatedPrice;

  CommercialBookingRequest({
    required this.userId,
    required this.businessType,
    required this.businessName,
    this.squareFootage,
    required this.date,
    required this.time,
    required this.address,
    this.afterHours = false,
    this.frequency = 'one-time',
    this.specialRequirements,
    required this.paymentMethod,
    this.estimatedPrice,
  });

  factory CommercialBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$CommercialBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommercialBookingRequestToJson(this);
}

@JsonSerializable()
class CommercialBookingResponse {
  final bool success;
  final String message;
  final String? bookingId;
  final CommercialBooking? booking;

  CommercialBookingResponse({
    required this.success,
    required this.message,
    this.bookingId,
    this.booking,
  });

  factory CommercialBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$CommercialBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommercialBookingResponseToJson(this);
}

@JsonSerializable()
class CommercialBooking {
  final String id;
  final String userId;
  final String businessType;
  final String businessName;
  final double? squareFootage;
  final String date;
  final String time;
  final String address;
  final bool afterHours;
  final String frequency;
  final String? specialRequirements;
  final String paymentMethod;
  final double? estimatedPrice;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CommercialBooking({
    required this.id,
    required this.userId,
    required this.businessType,
    required this.businessName,
    this.squareFootage,
    required this.date,
    required this.time,
    required this.address,
    this.afterHours = false,
    this.frequency = 'one-time',
    this.specialRequirements,
    required this.paymentMethod,
    this.estimatedPrice,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  factory CommercialBooking.fromJson(Map<String, dynamic> json) =>
      _$CommercialBookingFromJson(json);

  Map<String, dynamic> toJson() => _$CommercialBookingToJson(this);
}
