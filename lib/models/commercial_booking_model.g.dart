// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommercialBookingRequest _$CommercialBookingRequestFromJson(
  Map<String, dynamic> json,
) => CommercialBookingRequest(
  userId: json['userId'] as String,
  businessType: json['businessType'] as String,
  businessName: json['businessName'] as String,
  squareFootage: (json['squareFootage'] as num?)?.toDouble(),
  date: json['date'] as String,
  time: json['time'] as String,
  address: json['address'] as String,
  afterHours: json['afterHours'] as bool? ?? false,
  frequency: json['frequency'] as String? ?? 'one-time',
  specialRequirements: json['specialRequirements'] as String?,
  paymentMethod: json['paymentMethod'] as String,
  estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CommercialBookingRequestToJson(
  CommercialBookingRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'businessType': instance.businessType,
  'businessName': instance.businessName,
  'squareFootage': instance.squareFootage,
  'date': instance.date,
  'time': instance.time,
  'address': instance.address,
  'afterHours': instance.afterHours,
  'frequency': instance.frequency,
  'specialRequirements': instance.specialRequirements,
  'paymentMethod': instance.paymentMethod,
  'estimatedPrice': instance.estimatedPrice,
};

CommercialBookingResponse _$CommercialBookingResponseFromJson(
  Map<String, dynamic> json,
) => CommercialBookingResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  bookingId: json['bookingId'] as String?,
  booking: json['booking'] == null
      ? null
      : CommercialBooking.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommercialBookingResponseToJson(
  CommercialBookingResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'bookingId': instance.bookingId,
  'booking': instance.booking,
};

CommercialBooking _$CommercialBookingFromJson(Map<String, dynamic> json) =>
    CommercialBooking(
      id: json['id'] as String,
      userId: json['userId'] as String,
      businessType: json['businessType'] as String,
      businessName: json['businessName'] as String,
      squareFootage: (json['squareFootage'] as num?)?.toDouble(),
      date: json['date'] as String,
      time: json['time'] as String,
      address: json['address'] as String,
      afterHours: json['afterHours'] as bool? ?? false,
      frequency: json['frequency'] as String? ?? 'one-time',
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

Map<String, dynamic> _$CommercialBookingToJson(CommercialBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'businessType': instance.businessType,
      'businessName': instance.businessName,
      'squareFootage': instance.squareFootage,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'afterHours': instance.afterHours,
      'frequency': instance.frequency,
      'specialRequirements': instance.specialRequirements,
      'paymentMethod': instance.paymentMethod,
      'estimatedPrice': instance.estimatedPrice,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
