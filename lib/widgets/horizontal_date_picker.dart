import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class HorizontalDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final int daysToShow;

  const HorizontalDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.daysToShow = 14,
  });

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late ScrollController _scrollController;
  late List<DateTime> _dates;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _generateDates();
    
    // Scroll to selected date after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _generateDates() {
    _dates = List.generate(
      widget.daysToShow,
      (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  void _scrollToSelectedDate() {
    final index = _dates.indexWhere((date) =>
        date.year == widget.selectedDate.year &&
        date.month == widget.selectedDate.month &&
        date.day == widget.selectedDate.day);
    
    if (index != -1 && _scrollController.hasClients) {
      _scrollController.animateTo(
        index * 80.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pick a date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: AppColors.primaryCyan),
                  onPressed: () {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.offset - 240,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: AppColors.primaryCyan),
                  onPressed: () {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.offset + 240,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              final date = _dates[index];
              final isSelected = date.year == widget.selectedDate.year &&
                  date.month == widget.selectedDate.month &&
                  date.day == widget.selectedDate.day;
              
              return _buildDateCard(date, isSelected);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard(DateTime date, bool isSelected) {
    final dayName = DateFormat('EEE').format(date);
    final dayNumber = DateFormat('d').format(date);
    final monthName = DateFormat('MMM').format(date);

    return GestureDetector(
      onTap: () => widget.onDateSelected(date),
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryCyan : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primaryCyan.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.mediumGray,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              monthName,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? Colors.white.withOpacity(0.9) : AppColors.mediumGray,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              dayNumber,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
