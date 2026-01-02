// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeOrganizationRequest _$HomeOrganizationRequestFromJson(
  Map<String, dynamic> json,
) => HomeOrganizationRequest(
  userId: json['userId'] as String,
  organizationType: json['organizationType'] as String,
  estimatedHours: (json['estimatedHours'] as num).toInt(),
  date: json['date'] as String,
  time: json['time'] as String,
  address: json['address'] as String,
  needsSupplies: json['needsSupplies'] as bool? ?? false,
  preferredOrganizer: json['preferredOrganizer'] as String?,
  specialRequirements: json['specialRequirements'] as String?,
  paymentMethod: json['paymentMethod'] as String,
  estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
);

Map<String, dynamic> _$HomeOrganizationRequestToJson(
  HomeOrganizationRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'organizationType': instance.organizationType,
  'estimatedHours': instance.estimatedHours,
  'date': instance.date,
  'time': instance.time,
  'address': instance.address,
  'needsSupplies': instance.needsSupplies,
  'preferredOrganizer': instance.preferredOrganizer,
  'specialRequirements': instance.specialRequirements,
  'paymentMethod': instance.paymentMethod,
  'estimatedPrice': instance.estimatedPrice,
};

HomeOrganizationResponse _$HomeOrganizationResponseFromJson(
  Map<String, dynamic> json,
) => HomeOrganizationResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  bookingId: json['bookingId'] as String?,
  booking: json['booking'] == null
      ? null
      : HomeOrganization.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeOrganizationResponseToJson(
  HomeOrganizationResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'bookingId': instance.bookingId,
  'booking': instance.booking,
};

HomeOrganization _$HomeOrganizationFromJson(Map<String, dynamic> json) =>
    HomeOrganization(
      id: json['id'] as String,
      userId: json['userId'] as String,
      organizationType: json['organizationType'] as String,
      estimatedHours: (json['estimatedHours'] as num).toInt(),
      date: json['date'] as String,
      time: json['time'] as String,
      address: json['address'] as String,
      needsSupplies: json['needsSupplies'] as bool? ?? false,
      preferredOrganizer: json['preferredOrganizer'] as String?,
      specialRequirements: json['specialRequirements'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
      status: json['status'] as String? ?? 'pending',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$HomeOrganizationToJson(HomeOrganization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'organizationType': instance.organizationType,
      'estimatedHours': instance.estimatedHours,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'needsSupplies': instance.needsSupplies,
      'preferredOrganizer': instance.preferredOrganizer,
      'specialRequirements': instance.specialRequirements,
      'paymentMethod': instance.paymentMethod,
      'estimatedPrice': instance.estimatedPrice,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
