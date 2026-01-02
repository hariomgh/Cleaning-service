import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double? width;

  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.isSelected = false,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        padding: const EdgeInsets.all(16),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.lightCyan
                      : AppColors.backgroundGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: icon,
              ),
              const SizedBox(height: 12),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.mediumGray,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
