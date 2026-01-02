import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NumberSelectorWidget extends StatelessWidget {
  final int value;
  final Function(int) onChanged;
  final int minValue;
  final int maxValue;
  final String? label;
  final String? pricePerUnit;

  const NumberSelectorWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.minValue = 1,
    this.maxValue = 10,
    this.label,
    this.pricePerUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Decrement button
        GestureDetector(
          onTap: value > minValue ? () => onChanged(value - 1) : null,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value > minValue ? AppColors.primaryCyan : AppColors.borderGray,
            ),
            child: Icon(
              Icons.remove,
              color: value > minValue ? Colors.white : AppColors.mediumGray,
              size: 20,
            ),
          ),
        ),
        
        const SizedBox(width: 24),
        
        // Value display
        Column(
          children: [
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText,
              ),
            ),
            if (label != null)
              Text(
                label!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.mediumGray,
                ),
              ),
            if (pricePerUnit != null)
              Text(
                pricePerUnit!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mediumGray,
                ),
              ),
          ],
        ),
        
        const SizedBox(width: 24),
        
        // Increment button
        GestureDetector(
          onTap: value < maxValue ? () => onChanged(value + 1) : null,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value < maxValue ? AppColors.primaryCyan : AppColors.borderGray,
            ),
            child: Icon(
              Icons.add,
              color: value < maxValue ? Colors.white : AppColors.mediumGray,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
