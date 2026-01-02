import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/image_upload_widget.dart';

class CommercialDetailsForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic>? initialData;

  const CommercialDetailsForm({
    super.key,
    required this.onDataChanged,
    this.initialData,
  });

  @override
  State<CommercialDetailsForm> createState() => _CommercialDetailsFormState();
}

class _CommercialDetailsFormState extends State<CommercialDetailsForm> {
  String? _buildingType;
  String _contactTime = 'Noon';
  String _comments = '';
  List<String> _images = [];

  final Map<String, IconData> _buildingTypes = {
    'Office': Icons.business,
    'Store/Retail': Icons.store,
    'Medical Office': Icons.local_hospital,
    'School': Icons.school,
    'Bank': Icons.account_balance,
    'Factory': Icons.factory,
    'Other': Icons.more_horiz,
  };

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _buildingType = widget.initialData!['buildingType'];
      _contactTime = widget.initialData!['contactTime'] ?? 'Noon';
      _comments = widget.initialData!['comments'] ?? '';
      _images = List<String>.from(widget.initialData!['images'] ?? []);
    }
  }

  void _notifyDataChanged() {
    widget.onDataChanged({
      'buildingType': _buildingType,
      'contactTime': _contactTime,
      'comments': _comments,
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
            'Commercial Cleaning',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tell us about your commercial space',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 32),

          // Building Type
          const Text(
            'Building Type',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
            children: _buildingTypes.entries.map((entry) {
              final isSelected = _buildingType == entry.key;
              return GestureDetector(
                onTap: () {
                  setState(() => _buildingType = entry.key);
                  _notifyDataChanged();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
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
                    children: [
                      Icon(
                        entry.value,
                        size: 32,
                        color: isSelected ? AppColors.primaryCyan : AppColors.mediumGray,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.key,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 32),

          // Best Contact Time
          const Text(
            'Best Contact Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildContactTimeButton('Morning'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContactTimeButton('Noon'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContactTimeButton('Afternoon'),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Comments or Questions
          const Text(
            'Comments or Questions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please provide any additional information that may be unique to your facility. Such as, if you have a kitchen and/or restroom, or if you know the square footage of your facility.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.mediumGray,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Tell us about your space...',
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
              _comments = value;
              _notifyDataChanged();
            },
          ),

          const SizedBox(height: 32),

          // Images
          ImageUploadWidget(
            label: 'Images (Optional)',
            selectedImages: _images,
            onImagesChanged: (images) {
              setState(() => _images = images);
              _notifyDataChanged();
            },
          ),

          const SizedBox(height: 8),
          const Text(
            'Please provide images of the space.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.mediumGray,
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildContactTimeButton(String time) {
    final isSelected = _contactTime == time;
    return GestureDetector(
      onTap: () {
        setState(() => _contactTime = time);
        _notifyDataChanged();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          time,
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
}
