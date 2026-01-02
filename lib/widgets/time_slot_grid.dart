import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TimeSlotGrid extends StatelessWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeSelected;
  final List<TimeOfDay>? availableSlots;

  const TimeSlotGrid({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
    this.availableSlots,
  });

  List<TimeOfDay> get _defaultTimeSlots => [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 30),
    const TimeOfDay(hour: 10, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 11, minute: 0),
    const TimeOfDay(hour: 11, minute: 30),
    const TimeOfDay(hour: 12, minute: 0),
    const TimeOfDay(hour: 13, minute: 0),
    const TimeOfDay(hour: 13, minute: 30),
    const TimeOfDay(hour: 14, minute: 0),
    const TimeOfDay(hour: 14, minute: 30),
  ];

  @override
  Widget build(BuildContext context) {
    final slots = availableSlots ?? _defaultTimeSlots;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2,
          ),
          itemCount: slots.length,
          itemBuilder: (context, index) {
            final timeSlot = slots[index];
            final isSelected = timeSlot.hour == selectedTime.hour &&
                timeSlot.minute == selectedTime.minute;
            
            return _buildTimeSlotButton(timeSlot, isSelected);
          },
        ),
      ],
    );
  }

  Widget _buildTimeSlotButton(TimeOfDay time, bool isSelected) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final timeString = '$hour:$minute $period';

    return GestureDetector(
      onTap: () => onTimeSelected(time),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            timeString,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
            ),
          ),
        ),
      ),
    );
  }
}
