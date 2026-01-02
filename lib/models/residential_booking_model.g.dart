// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residential_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResidentialBookingRequest _$ResidentialBookingRequestFromJson(
  Map<String, dynamic> json,
) => ResidentialBookingRequest(
  userId: json['userId'] as String,
  serviceType: json['serviceType'] as String,
  date: json['date'] as String,
  time: json['time'] as String,
  address: json['address'] as String,
  morningPreferred: json['morningPreferred'] as bool? ?? false,
  bringProducts: json['bringProducts'] as bool? ?? false,
  preferredCleaner: json['preferredCleaner'] as String?,
  paymentMethod: json['paymentMethod'] as String,
  estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ResidentialBookingRequestToJson(
  ResidentialBookingRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'serviceType': instance.serviceType,
  'date': instance.date,
  'time': instance.time,
  'address': instance.address,
  'morningPreferred': instance.morningPreferred,
  'bringProducts': instance.bringProducts,
  'preferredCleaner': instance.preferredCleaner,
  'paymentMethod': instance.paymentMethod,
  'estimatedPrice': instance.estimatedPrice,
};

ResidentialBookingResponse _$ResidentialBookingResponseFromJson(
  Map<String, dynamic> json,
) => ResidentialBookingResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  bookingId: json['bookingId'] as String?,
  booking: json['booking'] == null
      ? null
      : ResidentialBooking.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResidentialBookingResponseToJson(
  ResidentialBookingResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'bookingId': instance.bookingId,
  'booking': instance.booking,
};

ResidentialBooking _$ResidentialBookingFromJson(Map<String, dynamic> json) =>
    ResidentialBooking(
      id: json['id'] as String,
      userId: json['userId'] as String,
      serviceType: json['serviceType'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      address: json['address'] as String,
      morningPreferred: json['morningPreferred'] as bool? ?? false,
      bringProducts: json['bringProducts'] as bool? ?? false,
      preferredCleaner: json['preferredCleaner'] as String?,
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

Map<String, dynamic> _$ResidentialBookingToJson(ResidentialBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'serviceType': instance.serviceType,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'morningPreferred': instance.morningPreferred,
      'bringProducts': instance.bringProducts,
      'preferredCleaner': instance.preferredCleaner,
      'paymentMethod': instance.paymentMethod,
      'estimatedPrice': instance.estimatedPrice,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
