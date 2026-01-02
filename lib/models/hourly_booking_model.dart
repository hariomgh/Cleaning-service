import 'package:json_annotation/json_annotation.dart';

part 'hourly_booking_model.g.dart';

@JsonSerializable()
class HourlyBookingRequest {
  final String userId;
  final int hours;
  final String date;
  final String time;
  final String address;
  final bool bringProducts;
  final String? preferredCleaner;
  final String paymentMethod;
  final double? estimatedPrice;
  final String? specialInstructions;

  HourlyBookingRequest({
    required this.userId,
    required this.hours,
    required this.date,
    required this.time,
    required this.address,
    this.bringProducts = false,
    this.preferredCleaner,
    required this.paymentMethod,
    this.estimatedPrice,
    this.specialInstructions,
  });

  factory HourlyBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$HourlyBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyBookingRequestToJson(this);
}

@JsonSerializable()
class HourlyBookingResponse {
  final bool success;
  final String message;
  final String? bookingId;
  final HourlyBooking? booking;

  HourlyBookingResponse({
    required this.success,
    required this.message,
    this.bookingId,
    this.booking,
  });

  factory HourlyBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$HourlyBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyBookingResponseToJson(this);
}

@JsonSerializable()
class HourlyBooking {
  final String id;
  final String userId;
  final int hours;
  final String date;
  final String time;
  final String address;
  final bool bringProducts;
  final String? preferredCleaner;
  final String paymentMethod;
  final double? estimatedPrice;
  final String? specialInstructions;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HourlyBooking({
    required this.id,
    required this.userId,
    required this.hours,
    required this.date,
    required this.time,
    required this.address,
    this.bringProducts = false,
    this.preferredCleaner,
    required this.paymentMethod,
    this.estimatedPrice,
    this.specialInstructions,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  factory HourlyBooking.fromJson(Map<String, dynamic> json) =>
      _$HourlyBookingFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyBookingToJson(this);
}
