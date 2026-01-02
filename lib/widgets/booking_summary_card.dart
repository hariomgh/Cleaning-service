import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../viewmodels/booking_viewmodel.dart';

class BookingSummaryCard extends StatelessWidget {
  final String? serviceType;
  final String? serviceDetails;
  final String? address;
  final DateTime? date;
  final TimeOfDay? time;
  final String? duration;
  final double totalPrice;
  final bool isCompact;

  const BookingSummaryCard({
    super.key,
    this.serviceType,
    this.serviceDetails,
    this.address,
    this.date,
    this.time,
    this.duration,
    required this.totalPrice,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (serviceType != null) ...[
            Text(
              serviceType!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText,
              ),
            ),
            if (serviceDetails != null) ...[
              const SizedBox(height: 4),
              Text(
                serviceDetails!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.mediumGray,
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],

          if (address != null) ...[
            _buildInfoRow(
              Icons.location_on_outlined,
              address!,
            ),
            const SizedBox(height: 12),
          ],

          if (date != null) ...[
            _buildInfoRow(
              Icons.calendar_today_outlined,
              DateFormat('EEEE, MMMM d').format(date!) + 
                (time != null ? '\n${_formatTime(time!)}' : ''),
            ),
            const SizedBox(height: 12),
          ],

          if (duration != null) ...[
            _buildInfoRow(
              Icons.access_time_outlined,
              duration!,
            ),
            const SizedBox(height: 16),
          ],

          const Divider(color: AppColors.borderGray),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Total",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryCyan,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.primaryCyan,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.darkText,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
