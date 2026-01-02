import 'package:json_annotation/json_annotation.dart';

part 'home_organization_model.g.dart';

@JsonSerializable()
class HomeOrganizationRequest {
  final String userId;
  final String organizationType; // 'closet', 'garage', 'kitchen', 'whole-home', 'other'
  final int estimatedHours;
  final String date;
  final String time;
  final String address;
  final bool needsSupplies;
  final String? preferredOrganizer;
  final String? specialRequirements;
  final String paymentMethod;
  final double? estimatedPrice;

  HomeOrganizationRequest({
    required this.userId,
    required this.organizationType,
    required this.estimatedHours,
    required this.date,
    required this.time,
    required this.address,
    this.needsSupplies = false,
    this.preferredOrganizer,
    this.specialRequirements,
    required this.paymentMethod,
    this.estimatedPrice,
  });

  factory HomeOrganizationRequest.fromJson(Map<String, dynamic> json) =>
      _$HomeOrganizationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HomeOrganizationRequestToJson(this);
}

@JsonSerializable()
class HomeOrganizationResponse {
  final bool success;
  final String message;
  final String? bookingId;
  final HomeOrganization? booking;

  HomeOrganizationResponse({
    required this.success,
    required this.message,
    this.bookingId,
    this.booking,
  });

  factory HomeOrganizationResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeOrganizationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeOrganizationResponseToJson(this);
}

@JsonSerializable()
class HomeOrganization {
  final String id;
  final String userId;
  final String organizationType;
  final int estimatedHours;
  final String date;
  final String time;
  final String address;
  final bool needsSupplies;
  final String? preferredOrganizer;
  final String? specialRequirements;
  final String paymentMethod;
  final double? estimatedPrice;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HomeOrganization({
    required this.id,
    required this.userId,
    required this.organizationType,
    required this.estimatedHours,
    required this.date,
    required this.time,
    required this.address,
    this.needsSupplies = false,
    this.preferredOrganizer,
    this.specialRequirements,
    required this.paymentMethod,
    this.estimatedPrice,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  factory HomeOrganization.fromJson(Map<String, dynamic> json) =>
      _$HomeOrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$HomeOrganizationToJson(this);
}
