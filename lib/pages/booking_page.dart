import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../viewmodels/booking_viewmodel.dart';
import '../widgets/booking_progress_indicator.dart';
import '../widgets/selection_card.dart';
import '../widgets/booking_cart_widget.dart';
import '../widgets/horizontal_date_picker.dart';
import '../widgets/time_slot_grid.dart';
import '../widgets/booking_summary_card.dart';
import '../widgets/residential_details_form.dart';
import '../widgets/hourly_details_form.dart';
import '../widgets/commercial_details_form.dart';
import '../widgets/home_organizing_form.dart';
import '../models/service_package.dart';

class BookingPage extends StatefulWidget {
  final BookingType? initialBookingType;
  final String? initialCity;
  
  const BookingPage({super.key, this.initialBookingType, this.initialCity});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _currentStep = 0;
  final int _totalSteps = 7;
  
  final List<String> _stepLabels = [
    'Borough',
    'Service',
    'Type',
    'Details',
    'Date & Time',
    'Address',
    'Payment',
  ];

  // Cart state
  bool _isCartExpanded = false;

  // Step 0: City Selection
  String? _selectedCity;

  // Step 1: Booking Type
  BookingType? _bookingType;

  // Step 2: Service Package
  ServicePackage? _selectedPackage;

  // Step 3: Service Details & Add-ons
  Map<String, dynamic> _residentialDetails = {};
  Map<String, dynamic> _hourlyDetails = {};
  Map<String, dynamic> _commercialDetails = {};
  Map<String, dynamic> _homeOrgDetails = {};

  // Step 4: Date & Time
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  // Step 5: Service Address
  String _streetAddress = '';
  String _aptUnitFloor = '';
  String _city = '';
  String _state = '';
  String _zipCode = '';

  // Step 6: Payment & Contact
  String _cardNumber = '';
  String _cardExpiry = '';
  String _cardCvc = '';
  String _tipAmount = 'None';
  String _fullName = '';
  String _phoneNumber = '';
  String _emailAddress = '';
  bool _smsNotifications = false;

  // Payment
  String _selectedCard = 'Visa **** 4594';

  late BookingViewModel _bookingViewModel;

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.initialCity;
    _bookingType = widget.initialBookingType;
    if (_selectedCity != null) _currentStep = 1; // Skip city if provided
    if (_bookingType != null) _currentStep = 2; // Skip type if provided
    _bookingViewModel = Provider.of<BookingViewModel>(context, listen: false);
    _bookingViewModel.addListener(_onBookingStateChanged);
  }

  @override
  void dispose() {
    _bookingViewModel.removeListener(_onBookingStateChanged);
    super.dispose();
  }

  void _onBookingStateChanged() {
    if (_bookingViewModel.state == BookingState.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_bookingViewModel.successMessage ?? 'Booking Confirmed!'),
          backgroundColor: AppColors.successGreen,
        ),
      );
      Navigator.pop(context);
    } else if (_bookingViewModel.state == BookingState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_bookingViewModel.errorMessage ?? 'Booking failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  void _nextStep() {
    if (_canProceed()) {
      if (_currentStep < _totalSteps - 1) {
        setState(() {
          _currentStep++;
        });
      } else {
        _confirmBooking();
      }
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedCity != null;
      case 1:
        return _bookingType != null;
      case 2:
        return _selectedPackage != null;
      case 3:
        return true; // Details are optional
      case 4:
        return true; // Date/time have defaults
      case 5:
        return _streetAddress.isNotEmpty && _city.isNotEmpty && 
               _state.isNotEmpty && _zipCode.isNotEmpty;
      case 6:
        return _cardNumber.isNotEmpty && _cardExpiry.isNotEmpty && 
               _cardCvc.isNotEmpty && _fullName.isNotEmpty && 
               _phoneNumber.isNotEmpty && _emailAddress.isNotEmpty;
      default:
        return true;
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _confirmBooking() async {
    // Build full address from new address fields
    final fullAddress = '$_streetAddress${_aptUnitFloor.isNotEmpty ? ', $_aptUnitFloor' : ''}, $_city, $_state $_zipCode';

    final timeString = '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
    final totalPrice = _getTotalPrice();
    
    switch (_bookingType!) {
      case BookingType.residential:
        await _bookingViewModel.createResidentialBooking(
          serviceType: _selectedPackage!.name,
          date: _selectedDate,
          time: timeString,
          address: fullAddress,
          morningPreferred: _residentialDetails['frequency'] == 'Morning',
          bringProducts: _residentialDetails['cleaningProducts'] == 'Normal',
          preferredCleaner: null,
          paymentMethod: 'Card ending in ${_cardNumber.length >= 4 ? _cardNumber.substring(_cardNumber.length - 4) : "****"}',
          estimatedPrice: totalPrice,
        );
        break;
      case BookingType.hourly:
        final hours = _hourlyDetails['hours'] ?? 3;
        await _bookingViewModel.createHourlyBooking(
          hours: hours,
          date: _selectedDate,
          time: timeString,
          address: fullAddress,
          bringProducts: false,
          preferredCleaner: null,
          paymentMethod: 'Card ending in ${_cardNumber.length >= 4 ? _cardNumber.substring(_cardNumber.length - 4) : "****"}',
          estimatedPrice: totalPrice,
          specialInstructions: _hourlyDetails['specialNotes'],
        );
        break;
      case BookingType.commercial:
        await _bookingViewModel.createCommercialBooking(
          businessType: _commercialDetails['buildingType'] ?? 'Office',
          businessName: 'Business',
          squareFootage: null,
          date: _selectedDate,
          time: timeString,
          address: fullAddress,
          afterHours: false,
          frequency: 'one-time',
          specialRequirements: _commercialDetails['comments'],
          paymentMethod: 'Card ending in ${_cardNumber.length >= 4 ? _cardNumber.substring(_cardNumber.length - 4) : "****"}',
          estimatedPrice: totalPrice,
        );
        break;
      case BookingType.homeOrganization:
        final hours = _homeOrgDetails['hours'] ?? 3;
        await _bookingViewModel.createHomeOrganizationBooking(
          organizationType: 'general',
          estimatedHours: hours,
          date: _selectedDate,
          time: timeString,
          address: fullAddress,
          needsSupplies: false,
          preferredOrganizer: null,
          specialRequirements: _homeOrgDetails['description'],
          paymentMethod: 'Card ending in ${_cardNumber.length >= 4 ? _cardNumber.substring(_cardNumber.length - 4) : "****"}',
          estimatedPrice: totalPrice,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundGray,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
              onPressed: viewModel.isLoading ? null : _prevStep,
            ),
            title: const Text(
              'Book Service',
              style: TextStyle(
                color: AppColors.darkText,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Progress Indicator
              BookingProgressIndicator(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
                stepLabels: _stepLabels,
              ),

              // Step Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: _buildStepContent(),
                ),
              ),

              // Cart Widget
              BookingCartWidget(
                selectedCity: _selectedCity,
                bookingType: _bookingType,
                selectedPackage: _selectedPackage,
                selectedDate: _selectedDate,
                selectedTime: _selectedTime,
                selectedAddress: _streetAddress.isNotEmpty ? '$_streetAddress, $_city' : null,
                addOnsTotal: _getTotalPrice() - (_selectedPackage?.basePrice ?? 0.0),
                isExpanded: _isCartExpanded,
                onToggle: () => setState(() => _isCartExpanded = !_isCartExpanded),
              ),

              // Bottom Button
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (viewModel.isLoading || !_canProceed()) ? null : _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryCyan,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        disabledBackgroundColor: AppColors.borderGray,
                      ),
                      child: viewModel.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              _currentStep == _totalSteps - 1 ? 'Book Now' : 'Continue',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep0CitySelection();
      case 1:
        return _buildStep1BookingType();
      case 2:
        return _buildStep2ServicePackages();
      case 3:
        return _buildStep3ServiceDetails();
      case 4:
        return _buildStep4DateTime();
      case 5:
        return _buildStep5Address();
      case 6:
        return _buildStep6Payment();
      default:
        return const SizedBox.shrink();
    }
  }

  // Step 0: City Selection
  Widget _buildStep0CitySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Your City',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose the city where you need service',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mediumGray,
          ),
        ),
        const SizedBox(height: 32),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
          children: availableCities.map((city) {
            return SelectionCard(
              title: city,
              icon: Icon(
                Icons.location_city,
                size: 28,
                color: _selectedCity == city ? AppColors.primaryCyan : AppColors.mediumGray,
              ),
              isSelected: _selectedCity == city,
              onTap: () => setState(() => _selectedCity = city),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Step 1: Booking Type Selection
  Widget _buildStep1BookingType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Booking Type',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose the type of service you need',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mediumGray,
          ),
        ),
        const SizedBox(height: 32),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [
            SelectionCard(
              title: 'Residential',
              subtitle: 'Home cleaning',
              icon: const Icon(Icons.home, size: 32, color: AppColors.primaryCyan),
              isSelected: _bookingType == BookingType.residential,
              onTap: () => setState(() {
                _bookingType = BookingType.residential;
                _selectedPackage = null; // Reset package when type changes
              }),
            ),
            SelectionCard(
              title: 'Hourly',
              subtitle: 'Flexible hours',
              icon: const Icon(Icons.access_time, size: 32, color: AppColors.primaryCyan),
              isSelected: _bookingType == BookingType.hourly,
              onTap: () => setState(() {
                _bookingType = BookingType.hourly;
                _selectedPackage = null;
              }),
            ),
            SelectionCard(
              title: 'Commercial',
              subtitle: 'Business spaces',
              icon: const Icon(Icons.business, size: 32, color: AppColors.primaryCyan),
              isSelected: _bookingType == BookingType.commercial,
              onTap: () => setState(() {
                _bookingType = BookingType.commercial;
                _selectedPackage = null;
              }),
            ),
            SelectionCard(
              title: 'Home Org',
              subtitle: 'Organization',
              icon: const Icon(Icons.inventory_2, size: 32, color: AppColors.primaryCyan),
              isSelected: _bookingType == BookingType.homeOrganization,
              onTap: () => setState(() {
                _bookingType = BookingType.homeOrganization;
                _selectedPackage = null;
              }),
            ),
          ],
        ),
      ],
    );
  }

  // Step 2: Service Packages
  Widget _buildStep2ServicePackages() {
    final packages = _getPackagesForType();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Service Package',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select the package that best fits your needs',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mediumGray,
          ),
        ),
        const SizedBox(height: 32),
        ...packages.map((package) => _buildServicePackageCard(package)),
      ],
    );
  }

  List<ServicePackage> _getPackagesForType() {
    switch (_bookingType) {
      case BookingType.residential:
        return residentialPackages;
      case BookingType.hourly:
        return hourlyPackages;
      case BookingType.commercial:
        return commercialPackages;
      case BookingType.homeOrganization:
        return homeOrgPackages;
      default:
        return [];
    }
  }

  Widget _buildServicePackageCard(ServicePackage package) {
    final isSelected = _selectedPackage?.id == package.id;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPackage = package),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primaryCyan.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.lightCyan : AppColors.backgroundGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.cleaning_services,
                color: isSelected ? AppColors.primaryCyan : AppColors.mediumGray,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    package.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.mediumGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: AppColors.mediumGray),
                      const SizedBox(width: 4),
                      Text(
                        package.duration,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '€${package.basePrice.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
                  ),
                ),
                if (isSelected)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryCyan,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Selected',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Step 3: Service Details & Add-ons
  Widget _buildStep3ServiceDetails() {
    switch (_bookingType) {
      case BookingType.residential:
        return ResidentialDetailsForm(
          initialData: _residentialDetails,
          onDataChanged: (data) {
            setState(() => _residentialDetails = data);
          },
        );
      case BookingType.hourly:
        return HourlyDetailsForm(
          initialData: _hourlyDetails,
          onDataChanged: (data) {
            setState(() => _hourlyDetails = data);
          },
        );
      case BookingType.commercial:
        return CommercialDetailsForm(
          initialData: _commercialDetails,
          onDataChanged: (data) {
            setState(() => _commercialDetails = data);
          },
        );
      case BookingType.homeOrganization:
        return HomeOrganizingForm(
          initialData: _homeOrgDetails,
          onDataChanged: (data) {
            setState(() => _homeOrgDetails = data);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }



  // Step 4: Date & Time
  Widget _buildStep4DateTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date & Time',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pick a date and time for your appointment, and we\'ll be there.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mediumGray,
          ),
        ),
        const SizedBox(height: 32),

        // Horizontal Date Picker
        HorizontalDatePicker(
          selectedDate: _selectedDate,
          onDateSelected: (date) {
            setState(() => _selectedDate = date);
          },
        ),

        const SizedBox(height: 32),

        // Time Slot Grid
        TimeSlotGrid(
          selectedTime: _selectedTime,
          onTimeSelected: (time) {
            setState(() => _selectedTime = time);
          },
        ),

        const SizedBox(height: 32),


      ],
    );
  }

  String _getDuration() {
    if (_bookingType == BookingType.hourly && _hourlyDetails['hours'] != null) {
      return '${_hourlyDetails['hours']} hr';
    } else if (_bookingType == BookingType.homeOrganization && _homeOrgDetails['hours'] != null) {
      return '${_homeOrgDetails['hours']} hr';
    } else if (_selectedPackage != null) {
      return _selectedPackage!.duration;
    }
    return '5 hr';
  }

  double _getTotalPrice() {
    double basePrice = _selectedPackage?.basePrice ?? 0.0;
    
    // Add extras from residential details
    if (_bookingType == BookingType.residential && _residentialDetails['extras'] != null) {
      final extras = _residentialDetails['extras'] as List<dynamic>;
      for (var extra in extras) {
        // Add pricing logic for extras
        if (extra == 'Deep Cleaning' || extra == 'Inside Cabinets' || extra == 'Laundry Wash & Dry') {
          basePrice += 35;
        } else if (extra == 'Fridge Cleaning' || extra == 'Oven Cleaning' || extra == 'Window Cleaning' || extra == 'Balcony Cleaning') {
          basePrice += 30;
        } else if (extra == 'Organization') {
          basePrice += 25;
        } else if (extra == 'Move In/Out') {
          basePrice += 170;
        }
      }
    }
    
    // Add extras from hourly details
    if (_bookingType == BookingType.hourly && _hourlyDetails['extras'] != null) {
      final extras = _hourlyDetails['extras'] as List<dynamic>;
      for (var extra in extras) {
        if (extra == 'Deep Cleaning' || extra == 'Inside Cabinets' || extra == 'Laundry Wash & Dry') {
          basePrice += 35;
        } else if (extra == 'Fridge Cleaning' || extra == 'Oven Cleaning' || extra == 'Window Cleaning' || extra == 'Balcony Cleaning') {
          basePrice += 30;
        } else if (extra == 'Organization') {
          basePrice += 25;
        } else if (extra == 'Move In/Out') {
          basePrice += 170;
        }
      }
    }
    
    return basePrice;
  }

  // Step 5: Service Address
  Widget _buildStep5Address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service Address',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Where should we provide the service?',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mediumGray,
          ),
        ),
        const SizedBox(height: 32),

        // Street address
        const Text(
          'Street address',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Street',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          onChanged: (value) => setState(() => _streetAddress = value),
        ),

        const SizedBox(height: 20),

        // Apt, Unit, Floor
        const Text(
          'Apt, Unit, Floor',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Apt 4B',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          onChanged: (value) => setState(() => _aptUnitFloor = value),
        ),

        const SizedBox(height: 20),

        // City, State, Zip Code row
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'City',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.borderGray),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.borderGray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onChanged: (value) => setState(() => _city = value),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'State',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'State',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.borderGray),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.borderGray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onChanged: (value) => setState(() => _state = value),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Zip Code',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Zip code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.borderGray),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.borderGray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() => _zipCode = value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Step 6: Payment & Contact
  Widget _buildStep6Payment() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Almost Done!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your payment & contact info to finalize your appointment.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 32),

          // Credit Card Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGray),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Credit Card',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Card number
                const Text(
                  'Card number *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: '1234 5678 9012 3456',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGray),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => setState(() => _cardNumber = value),
                ),

                const SizedBox(height: 16),

                // MM/YY and CVC row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'MM / YY *',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'MM/YY',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(() => _cardExpiry = value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CVC *',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: '123',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            onChanged: (value) => setState(() => _cardCvc = value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Text(
                  'No payment due until after your cleaning. Satisfaction guaranteed.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.mediumGray,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    // Open refund policy
                  },
                  child: const Text(
                    'View our refund policy',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryCyan,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Add a tip Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGray),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add a tip?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTipButton('None')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildTipButton('\$10')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildTipButton('\$15')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildTipButton('\$20')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildTipButton('Custom')),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Contact Information Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGray),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 16),

                // Full Name
                const Text(
                  'Your Full Name *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'John Doe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGray),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onChanged: (value) => setState(() => _fullName = value),
                ),

                const SizedBox(height: 16),

                // Phone and Email row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Phone Number *',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: '(123) 456-7890',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) => setState(() => _phoneNumber = value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email Address *',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'john@example.com',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderGray),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => setState(() => _emailAddress = value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // SMS Notification checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _smsNotifications,
                      onChanged: (value) => setState(() => _smsNotifications = value ?? false),
                      activeColor: AppColors.primaryCyan,
                    ),
                    const Expanded(
                      child: Text(
                        'Send me notifications about this appointment via text message',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Apply coupon link
          GestureDetector(
            onTap: () {
              // Open coupon dialog
            },
            child: const Text(
              'Apply coupon',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryCyan,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTipButton(String amount) {
    final isSelected = _tipAmount == amount;
    return GestureDetector(
      onTap: () => setState(() => _tipAmount = amount),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          amount,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
          ),
        ),
      ),
    );
  }

  String _getBookingTypeName() {
    switch (_bookingType) {
      case BookingType.residential:
        return 'Residential';
      case BookingType.hourly:
        return 'Hourly';
      case BookingType.commercial:
        return 'Commercial';
      case BookingType.homeOrganization:
        return 'Home Organization';
      default:
        return 'N/A';
    }
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, bool isPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.mediumGray,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isPrice ? 20 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isPrice ? AppColors.primaryCyan : AppColors.darkText,
          ),
        ),
      ],
    );
  }
}
