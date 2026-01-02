import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/residential_booking_model.dart';
import '../models/hourly_booking_model.dart';
import '../models/commercial_booking_model.dart';
import '../models/home_organization_model.dart';
import '../repositories/booking_repository.dart';
import '../utils/constants.dart';

enum BookingType {
  residential,
  hourly,
  commercial,
  homeOrganization,
}

enum BookingState {
  idle,
  loading,
  success,
  error,
}

class BookingViewModel extends ChangeNotifier {
  final BookingRepository _bookingRepository;

  BookingViewModel({BookingRepository? bookingRepository})
      : _bookingRepository = bookingRepository ?? BookingRepository();

  BookingState _state = BookingState.idle;
  String? _errorMessage;
  String? _successMessage;
  String? _bookingId;

  BookingState get state => _state;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  String? get bookingId => _bookingId;

  bool get isLoading => _state == BookingState.loading;

  void _setState(BookingState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(BookingState.error);
  }

  void _setSuccess(String message, String? bookingId) {
    _successMessage = message;
    _bookingId = bookingId;
    _setState(BookingState.success);
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    _bookingId = null;
    _setState(BookingState.idle);
  }

  /// Get user ID from shared preferences
  Future<String?> _getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(ApiConstants.userIdKey);
    } catch (e) {
      print('❌ Error getting user ID: $e');
      return null;
    }
  }

  /// Create a residential booking
  Future<void> createResidentialBooking({
    required String serviceType,
    required DateTime date,
    required String time,
    required String address,
    bool morningPreferred = false,
    bool bringProducts = false,
    String? preferredCleaner,
    required String paymentMethod,
    double? estimatedPrice,
  }) async {
    _setState(BookingState.loading);

    try {
      final userId = await _getUserId();
      if (userId == null) {
        _setError('User not logged in. Please log in to create a booking.');
        return;
      }

      final request = ResidentialBookingRequest(
        userId: userId,
        serviceType: serviceType,
        date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        time: time,
        address: address,
        morningPreferred: morningPreferred,
        bringProducts: bringProducts,
        preferredCleaner: preferredCleaner,
        paymentMethod: paymentMethod,
        estimatedPrice: estimatedPrice,
      );

      final response = await _bookingRepository.createResidentialBooking(request);

      if (response.success) {
        _setSuccess(
          response.message,
          response.bookingId ?? response.booking?.id,
        );
      } else {
        _setError(response.message);
      }
    } catch (e) {
      print('❌ Error in createResidentialBooking: $e');
      _setError('Failed to create booking. Please try again.');
    }
  }

  /// Create an hourly booking
  Future<void> createHourlyBooking({
    required int hours,
    required DateTime date,
    required String time,
    required String address,
    bool bringProducts = false,
    String? preferredCleaner,
    required String paymentMethod,
    double? estimatedPrice,
    String? specialInstructions,
  }) async {
    _setState(BookingState.loading);

    try {
      final userId = await _getUserId();
      if (userId == null) {
        _setError('User not logged in. Please log in to create a booking.');
        return;
      }

      final request = HourlyBookingRequest(
        userId: userId,
        hours: hours,
        date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        time: time,
        address: address,
        bringProducts: bringProducts,
        preferredCleaner: preferredCleaner,
        paymentMethod: paymentMethod,
        estimatedPrice: estimatedPrice,
        specialInstructions: specialInstructions,
      );

      final response = await _bookingRepository.createHourlyBooking(request);

      if (response.success) {
        _setSuccess(
          response.message,
          response.bookingId ?? response.booking?.id,
        );
      } else {
        _setError(response.message);
      }
    } catch (e) {
      print('❌ Error in createHourlyBooking: $e');
      _setError('Failed to create booking. Please try again.');
    }
  }

  /// Create a commercial booking
  Future<void> createCommercialBooking({
    required String businessType,
    required String businessName,
    double? squareFootage,
    required DateTime date,
    required String time,
    required String address,
    bool afterHours = false,
    String frequency = 'one-time',
    String? specialRequirements,
    required String paymentMethod,
    double? estimatedPrice,
  }) async {
    _setState(BookingState.loading);

    try {
      final userId = await _getUserId();
      if (userId == null) {
        _setError('User not logged in. Please log in to create a booking.');
        return;
      }

      final request = CommercialBookingRequest(
        userId: userId,
        businessType: businessType,
        businessName: businessName,
        squareFootage: squareFootage,
        date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        time: time,
        address: address,
        afterHours: afterHours,
        frequency: frequency,
        specialRequirements: specialRequirements,
        paymentMethod: paymentMethod,
        estimatedPrice: estimatedPrice,
      );

      final response = await _bookingRepository.createCommercialBooking(request);

      if (response.success) {
        _setSuccess(
          response.message,
          response.bookingId ?? response.booking?.id,
        );
      } else {
        _setError(response.message);
      }
    } catch (e) {
      print('❌ Error in createCommercialBooking: $e');
      _setError('Failed to create booking. Please try again.');
    }
  }

  /// Create a home organization booking
  Future<void> createHomeOrganizationBooking({
    required String organizationType,
    required int estimatedHours,
    required DateTime date,
    required String time,
    required String address,
    bool needsSupplies = false,
    String? preferredOrganizer,
    String? specialRequirements,
    required String paymentMethod,
    double? estimatedPrice,
  }) async {
    _setState(BookingState.loading);

    try {
      final userId = await _getUserId();
      if (userId == null) {
        _setError('User not logged in. Please log in to create a booking.');
        return;
      }

      final request = HomeOrganizationRequest(
        userId: userId,
        organizationType: organizationType,
        estimatedHours: estimatedHours,
        date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        time: time,
        address: address,
        needsSupplies: needsSupplies,
        preferredOrganizer: preferredOrganizer,
        specialRequirements: specialRequirements,
        paymentMethod: paymentMethod,
        estimatedPrice: estimatedPrice,
      );

      final response = await _bookingRepository.createHomeOrganizationBooking(request);

      if (response.success) {
        _setSuccess(
          response.message,
          response.bookingId ?? response.booking?.id,
        );
      } else {
        _setError(response.message);
      }
    } catch (e) {
      print('❌ Error in createHomeOrganizationBooking: $e');
      _setError('Failed to create booking. Please try again.');
    }
  }
}
