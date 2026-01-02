// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyBookingRequest _$HourlyBookingRequestFromJson(
  Map<String, dynamic> json,
) => HourlyBookingRequest(
  userId: json['userId'] as String,
  hours: (json['hours'] as num).toInt(),
  date: json['date'] as String,
  time: json['time'] as String,
  address: json['address'] as String,
  bringProducts: json['bringProducts'] as bool? ?? false,
  preferredCleaner: json['preferredCleaner'] as String?,
  paymentMethod: json['paymentMethod'] as String,
  estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
  specialInstructions: json['specialInstructions'] as String?,
);

Map<String, dynamic> _$HourlyBookingRequestToJson(
  HourlyBookingRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'hours': instance.hours,
  'date': instance.date,
  'time': instance.time,
  'address': instance.address,
  'bringProducts': instance.bringProducts,
  'preferredCleaner': instance.preferredCleaner,
  'paymentMethod': instance.paymentMethod,
  'estimatedPrice': instance.estimatedPrice,
  'specialInstructions': instance.specialInstructions,
};

HourlyBookingResponse _$HourlyBookingResponseFromJson(
  Map<String, dynamic> json,
) => HourlyBookingResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  bookingId: json['bookingId'] as String?,
  booking: json['booking'] == null
      ? null
      : HourlyBooking.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HourlyBookingResponseToJson(
  HourlyBookingResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'bookingId': instance.bookingId,
  'booking': instance.booking,
};

HourlyBooking _$HourlyBookingFromJson(Map<String, dynamic> json) =>
    HourlyBooking(
      id: json['id'] as String,
      userId: json['userId'] as String,
      hours: (json['hours'] as num).toInt(),
      date: json['date'] as String,
      time: json['time'] as String,
      address: json['address'] as String,
      bringProducts: json['bringProducts'] as bool? ?? false,
      preferredCleaner: json['preferredCleaner'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
      specialInstructions: json['specialInstructions'] as String?,
      status: json['status'] as String? ?? 'pending',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$HourlyBookingToJson(HourlyBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'hours': instance.hours,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'bringProducts': instance.bringProducts,
      'preferredCleaner': instance.preferredCleaner,
      'paymentMethod': instance.paymentMethod,
      'estimatedPrice': instance.estimatedPrice,
      'specialInstructions': instance.specialInstructions,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
