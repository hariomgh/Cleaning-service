import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BookingProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const BookingProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Progress bar
          Row(
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              
              return Expanded(
                child: Row(
                  children: [
                    // Step circle
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted || isCurrent
                            ? AppColors.primaryCyan
                            : AppColors.borderGray,
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              )
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isCurrent
                                      ? Colors.white
                                      : AppColors.mediumGray,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                      ),
                    ),
                    // Connector line
                    if (index < totalSteps - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted
                              ? AppColors.primaryCyan
                              : AppColors.borderGray,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          // Step labels
          Row(
            children: List.generate(totalSteps, (index) {
              final isCurrent = index == currentStep;
              
              return Expanded(
                child: Text(
                  stepLabels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                    color: isCurrent
                        ? AppColors.primaryCyan
                        : AppColors.mediumGray,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
