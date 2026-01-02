import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/service_package.dart';
import '../viewmodels/booking_viewmodel.dart';

class BookingCartWidget extends StatelessWidget {
  final String? selectedCity;
  final BookingType? bookingType;
  final ServicePackage? selectedPackage;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? selectedAddress;
  final double addOnsTotal;
  final bool isExpanded;
  final VoidCallback onToggle;

  const BookingCartWidget({
    super.key,
    this.selectedCity,
    this.bookingType,
    this.selectedPackage,
    this.selectedDate,
    this.selectedTime,
    this.selectedAddress,
    this.addOnsTotal = 0.0,
    this.isExpanded = true,
    required this.onToggle,
  });

  double get subtotal => selectedPackage?.basePrice ?? 0.0;
  double get total => subtotal + addOnsTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          InkWell(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.lightCyan,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: AppColors.primaryCyan,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Your Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText,
                      ),
                    ),
                  ),
                  Text(
                    '€${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryCyan,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                    color: AppColors.mediumGray,
                  ),
                ],
              ),
            ),
          ),

          // Expandable Content
          if (isExpanded) ...[
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedCity != null) ...[
                    _buildCartItem(
                      icon: Icons.location_on,
                      label: 'City',
                      value: selectedCity!,
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (bookingType != null) ...[
                    _buildCartItem(
                      icon: Icons.category,
                      label: 'Type',
                      value: _getBookingTypeName(bookingType!),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (selectedPackage != null) ...[
                    _buildCartItem(
                      icon: Icons.cleaning_services,
                      label: 'Service',
                      value: selectedPackage!.name,
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (selectedDate != null) ...[
                    _buildCartItem(
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (selectedTime != null) ...[
                    _buildCartItem(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: selectedTime!.format(context),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (selectedAddress != null) ...[
                    _buildCartItem(
                      icon: Icons.home,
                      label: 'Address',
                      value: selectedAddress!,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Price Breakdown
                  if (selectedPackage != null) ...[
                    const Divider(height: 24),
                    _buildPriceRow('Subtotal', subtotal),
                    if (addOnsTotal > 0) ...[
                      const SizedBox(height: 8),
                      _buildPriceRow('Add-ons', addOnsTotal),
                    ],
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.lightCyan,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkText,
                            ),
                          ),
                          Text(
                            '€${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryCyan,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryCyan),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.mediumGray,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.mediumGray,
          ),
        ),
        Text(
          '€${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }

  String _getBookingTypeName(BookingType type) {
    switch (type) {
      case BookingType.residential:
        return 'Residential';
      case BookingType.hourly:
        return 'Hourly';
      case BookingType.commercial:
        return 'Commercial';
      case BookingType.homeOrganization:
        return 'Home Organization';
    }
  }
}
