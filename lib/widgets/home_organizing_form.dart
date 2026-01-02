import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/number_selector_widget.dart';
import '../widgets/image_upload_widget.dart';

class HomeOrganizingForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic>? initialData;

  const HomeOrganizingForm({
    super.key,
    required this.onDataChanged,
    this.initialData,
  });

  @override
  State<HomeOrganizingForm> createState() => _HomeOrganizingFormState();
}

class _HomeOrganizingFormState extends State<HomeOrganizingForm> {
  int _hours = 3;
  String _description = '';
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _hours = widget.initialData!['hours'] ?? 3;
      _description = widget.initialData!['description'] ?? '';
      _images = List<String>.from(widget.initialData!['images'] ?? []);
    }
  }

  void _notifyDataChanged() {
    widget.onDataChanged({
      'hours': _hours,
      'description': _description,
      'images': _images,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Home Organizing',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Professional organizing services for your home',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 32),

          // Organizing Duration
          const Text(
            'Organizing Duration',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Hours \$\$\$\$ - Please select 3 hours or more of organizing as this is our minimum number of hours we provide.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.mediumGray,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          NumberSelectorWidget(
            value: _hours,
            onChanged: (value) {
              setState(() => _hours = value);
              _notifyDataChanged();
            },
            minValue: 3,
            maxValue: 10,
            label: 'hours',
          ),

          const SizedBox(height: 32),

          // Description
          const Text(
            'Please describe what you would like to be organized.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'hu',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderGray),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryCyan, width: 2),
              ),
            ),
            maxLines: 5,
            onChanged: (value) {
              _description = value;
              _notifyDataChanged();
            },
          ),

          const SizedBox(height: 32),

          // Images
          ImageUploadWidget(
            label: 'Do you have any pictures?',
            selectedImages: _images,
            onImagesChanged: (images) {
              setState(() => _images = images);
              _notifyDataChanged();
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
