import '../models/residential_booking_model.dart';
import '../models/hourly_booking_model.dart';
import '../models/commercial_booking_model.dart';
import '../models/home_organization_model.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class BookingRepository {
  final ApiService apiService;

  BookingRepository({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  /// Create a residential booking
  Future<ResidentialBookingResponse> createResidentialBooking(
      ResidentialBookingRequest request) async {
    print('🏠 BookingRepository: Creating residential booking');
    try {
      print('🏠 BookingRepository: Request object created: ${request.toJson()}');

      final response = await apiService.post(
        ApiConstants.residentialBookingEndpoint,
        request.toJson(),
      );

      print('🏠 BookingRepository: API response received, parsing to ResidentialBookingResponse');
      final bookingResponse = ResidentialBookingResponse.fromJson(response);
      print('🏠 BookingRepository: Response parsed successfully');
      print('   - Success: ${bookingResponse.success}');
      print('   - Message: ${bookingResponse.message}');
      print('   - Booking ID: ${bookingResponse.bookingId ?? "N/A"}');

      return bookingResponse;
    } catch (e) {
      print('🏠 BookingRepository: ❌ Error creating residential booking: ${e.toString()}');
      throw Exception('Failed to create residential booking: ${e.toString()}');
    }
  }

  /// Create an hourly booking
  Future<HourlyBookingResponse> createHourlyBooking(
      HourlyBookingRequest request) async {
    print('⏰ BookingRepository: Creating hourly booking');
    try {
      print('⏰ BookingRepository: Request object created: ${request.toJson()}');

      final response = await apiService.post(
        ApiConstants.hourlyBookingEndpoint,
        request.toJson(),
      );

      print('⏰ BookingRepository: API response received, parsing to HourlyBookingResponse');
      final bookingResponse = HourlyBookingResponse.fromJson(response);
      print('⏰ BookingRepository: Response parsed successfully');
      print('   - Success: ${bookingResponse.success}');
      print('   - Message: ${bookingResponse.message}');
      print('   - Booking ID: ${bookingResponse.bookingId ?? "N/A"}');

      return bookingResponse;
    } catch (e) {
      print('⏰ BookingRepository: ❌ Error creating hourly booking: ${e.toString()}');
      throw Exception('Failed to create hourly booking: ${e.toString()}');
    }
  }

  /// Create a commercial booking
  Future<CommercialBookingResponse> createCommercialBooking(
      CommercialBookingRequest request) async {
    print('🏢 BookingRepository: Creating commercial booking');
    try {
      print('🏢 BookingRepository: Request object created: ${request.toJson()}');

      final response = await apiService.post(
        ApiConstants.commercialBookingEndpoint,
        request.toJson(),
      );

      print('🏢 BookingRepository: API response received, parsing to CommercialBookingResponse');
      final bookingResponse = CommercialBookingResponse.fromJson(response);
      print('🏢 BookingRepository: Response parsed successfully');
      print('   - Success: ${bookingResponse.success}');
      print('   - Message: ${bookingResponse.message}');
      print('   - Booking ID: ${bookingResponse.bookingId ?? "N/A"}');

      return bookingResponse;
    } catch (e) {
      print('🏢 BookingRepository: ❌ Error creating commercial booking: ${e.toString()}');
      throw Exception('Failed to create commercial booking: ${e.toString()}');
    }
  }

  /// Get residential booking by ID
  Future<ResidentialBooking> getResidentialBookingById(String id) async {
    print('🏠 BookingRepository: Fetching residential booking with ID: $id');
    try {
      final endpoint = '${ApiConstants.residentialBookingEndpoint}$id';
      print('🏠 BookingRepository: Endpoint: $endpoint');

      final response = await apiService.get(endpoint);

      print('🏠 BookingRepository: API response received, parsing to ResidentialBooking');
      final booking = ResidentialBooking.fromJson(response);
      print('🏠 BookingRepository: Booking parsed successfully');

      return booking;
    } catch (e) {
      print('🏠 BookingRepository: ❌ Error getting residential booking: ${e.toString()}');
      throw Exception('Failed to get residential booking: ${e.toString()}');
    }
  }

  /// Get hourly booking by ID
  Future<HourlyBooking> getHourlyBookingById(String id) async {
    print('⏰ BookingRepository: Fetching hourly booking with ID: $id');
    try {
      final endpoint = '${ApiConstants.hourlyBookingEndpoint}$id';
      print('⏰ BookingRepository: Endpoint: $endpoint');

      final response = await apiService.get(endpoint);

      print('⏰ BookingRepository: API response received, parsing to HourlyBooking');
      final booking = HourlyBooking.fromJson(response);
      print('⏰ BookingRepository: Booking parsed successfully');

      return booking;
    } catch (e) {
      print('⏰ BookingRepository: ❌ Error getting hourly booking: ${e.toString()}');
      throw Exception('Failed to get hourly booking: ${e.toString()}');
    }
  }

  /// Get commercial booking by ID
  Future<CommercialBooking> getCommercialBookingById(String id) async {
    print('🏢 BookingRepository: Fetching commercial booking with ID: $id');
    try {
      final endpoint = '${ApiConstants.commercialBookingEndpoint}$id';
      print('🏢 BookingRepository: Endpoint: $endpoint');

      final response = await apiService.get(endpoint);

      print('🏢 BookingRepository: API response received, parsing to CommercialBooking');
      final booking = CommercialBooking.fromJson(response);
      print('🏢 BookingRepository: Booking parsed successfully');

      return booking;
    } catch (e) {
      print('🏢 BookingRepository: ❌ Error getting commercial booking: ${e.toString()}');
      throw Exception('Failed to get commercial booking: ${e.toString()}');
    }
  }

  /// Create a home organization booking
  Future<HomeOrganizationResponse> createHomeOrganizationBooking(
      HomeOrganizationRequest request) async {
    print('🏠📦 BookingRepository: Creating home organization booking');
    try {
      print('🏠📦 BookingRepository: Request object created: ${request.toJson()}');

      final response = await apiService.post(
        ApiConstants.homeOrganizationEndpoint,
        request.toJson(),
      );

      print('🏠📦 BookingRepository: API response received, parsing to HomeOrganizationResponse');
      final bookingResponse = HomeOrganizationResponse.fromJson(response);
      print('🏠📦 BookingRepository: Response parsed successfully');
      print('   - Success: ${bookingResponse.success}');
      print('   - Message: ${bookingResponse.message}');
      print('   - Booking ID: ${bookingResponse.bookingId ?? "N/A"}');

      return bookingResponse;
    } catch (e) {
      print('🏠📦 BookingRepository: ❌ Error creating home organization booking: ${e.toString()}');
      throw Exception('Failed to create home organization booking: ${e.toString()}');
    }
  }

  /// Get home organization booking by ID
  Future<HomeOrganization> getHomeOrganizationById(String id) async {
    print('🏠📦 BookingRepository: Fetching home organization booking with ID: $id');
    try {
      final endpoint = '${ApiConstants.homeOrganizationEndpoint}$id';
      print('🏠📦 BookingRepository: Endpoint: $endpoint');

      final response = await apiService.get(endpoint);

      print('🏠📦 BookingRepository: API response received, parsing to HomeOrganization');
      final booking = HomeOrganization.fromJson(response);
      print('🏠📦 BookingRepository: Booking parsed successfully');

      return booking;
    } catch (e) {
      print('🏠📦 BookingRepository: ❌ Error getting home organization booking: ${e.toString()}');
      throw Exception('Failed to get home organization booking: ${e.toString()}');
    }
  }
}
