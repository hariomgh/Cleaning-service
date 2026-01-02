import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class IconSelectionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? price;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? iconColor;

  const IconSelectionCard({
    super.key,
    required this.icon,
    required this.label,
    this.price,
    required this.isSelected,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primaryCyan.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? AppColors.primaryCyan
                  : (iconColor ?? AppColors.mediumGray),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (price != null) ...[
              const SizedBox(height: 2),
              Text(
                price!,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? AppColors.primaryCyan : AppColors.mediumGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
