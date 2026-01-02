import 'package:json_annotation/json_annotation.dart';

part 'residential_booking_model.g.dart';

@JsonSerializable()
class ResidentialBookingRequest {
  final String userId;
  final String serviceType;
  final String date;
  final String time;
  final String address;
  final bool morningPreferred;
  final bool bringProducts;
  final String? preferredCleaner;
  final String paymentMethod;
  final double? estimatedPrice;

  ResidentialBookingRequest({
    required this.userId,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.address,
    this.morningPreferred = false,
    this.bringProducts = false,
    this.preferredCleaner,
    required this.paymentMethod,
    this.estimatedPrice,
  });

  factory ResidentialBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$ResidentialBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResidentialBookingRequestToJson(this);
}

@JsonSerializable()
class ResidentialBookingResponse {
  final bool success;
  final String message;
  final String? bookingId;
  final ResidentialBooking? booking;

  ResidentialBookingResponse({
    required this.success,
    required this.message,
    this.bookingId,
    this.booking,
  });

  factory ResidentialBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$ResidentialBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResidentialBookingResponseToJson(this);
}

@JsonSerializable()
class ResidentialBooking {
  final String id;
  final String userId;
  final String serviceType;
  final String date;
  final String time;
  final String address;
  final bool morningPreferred;
  final bool bringProducts;
  final String? preferredCleaner;
  final String paymentMethod;
  final double? estimatedPrice;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ResidentialBooking({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.address,
    this.morningPreferred = false,
    this.bringProducts = false,
    this.preferredCleaner,
    required this.paymentMethod,
    this.estimatedPrice,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  factory ResidentialBooking.fromJson(Map<String, dynamic> json) =>
      _$ResidentialBookingFromJson(json);

  Map<String, dynamic> toJson() => _$ResidentialBookingToJson(this);
}
