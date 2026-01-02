import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/icon_selection_card.dart';
import '../widgets/number_selector_widget.dart';

class HourlyDetailsForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic>? initialData;

  const HourlyDetailsForm({
    super.key,
    required this.onDataChanged,
    this.initialData,
  });

  @override
  State<HourlyDetailsForm> createState() => _HourlyDetailsFormState();
}

class _HourlyDetailsFormState extends State<HourlyDetailsForm> {
  int _hours = 3;
  int _cleaners = 1;
  int _bedrooms = 3;
  int _bathrooms = 3;
  Set<String> _selectedExtras = {};
  bool _hasPets = false;
  String _accessMethod = 'Other';
  String _accessDescription = '';
  String _specialNotes = '';

  final Map<String, Map<String, dynamic>> _extras = {
    'Deep Cleaning': {'icon': Icons.cleaning_services, 'price': 35},
    'Inside Cabinets': {'icon': Icons.kitchen, 'price': 35},
    'Fridge Cleaning': {'icon': Icons.kitchen_outlined, 'price': 30},
    'Oven Cleaning': {'icon': Icons.microwave, 'price': 30},
    'Laundry Wash & Dry': {'icon': Icons.local_laundry_service, 'price': 35},
    'Window Cleaning': {'icon': Icons.window, 'price': 30},
    'Balcony Cleaning': {'icon': Icons.balcony, 'price': 30},
    'Organization': {'icon': Icons.inventory_2, 'price': 25},
    'Move In/Out': {'icon': Icons.moving, 'price': 170},
  };

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _hours = widget.initialData!['hours'] ?? 3;
      _cleaners = widget.initialData!['cleaners'] ?? 1;
      _bedrooms = widget.initialData!['bedrooms'] ?? 3;
      _bathrooms = widget.initialData!['bathrooms'] ?? 3;
      _selectedExtras = Set<String>.from(widget.initialData!['extras'] ?? []);
      _hasPets = widget.initialData!['hasPets'] ?? false;
      _accessMethod = widget.initialData!['accessMethod'] ?? 'Other';
      _accessDescription = widget.initialData!['accessDescription'] ?? '';
      _specialNotes = widget.initialData!['specialNotes'] ?? '';
    }
  }

  void _notifyDataChanged() {
    widget.onDataChanged({
      'hours': _hours,
      'cleaners': _cleaners,
      'bedrooms': _bedrooms,
      'bathrooms': _bathrooms,
      'extras': _selectedExtras.toList(),
      'hasPets': _hasPets,
      'accessMethod': _accessMethod,
      'accessDescription': _accessDescription,
      'specialNotes': _specialNotes,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hourly Standard Home Cleaning',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'For how many hours would you like to schedule a cleaning?',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 32),

          // Number of Hours
          const Text(
            'Number of Hours',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$\$\$\$ per hour',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
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

          // Number of Cleaners
          const Text(
            'Number of Cleaners',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Displayed total is showing the price for selected number of hours for one cleaner. Amount will also be adjusted for the number of cleaners selected.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.mediumGray,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          NumberSelectorWidget(
            value: _cleaners,
            onChanged: (value) {
              setState(() => _cleaners = value);
              _notifyDataChanged();
            },
            minValue: 1,
            maxValue: 5,
          ),

          const SizedBox(height: 32),

          // Number of Bedrooms
          const Text(
            'Number of Bedrooms',
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
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.0,
            children: [
              _buildRoomCard('Studio', 0),
              _buildRoomCard('1 Bedroom', 1),
              _buildRoomCard('2 Bedrooms', 2),
              _buildRoomCard('3 Bedrooms', 3),
              _buildRoomCard('4 Bedrooms', 4),
              _buildRoomCard('5 Bedrooms', 5),
            ],
          ),

          const SizedBox(height: 32),

          // Number of Bathrooms
          const Text(
            'Number of Bathrooms',
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
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.0,
            children: List.generate(5, (index) {
              final count = index + 1;
              return _buildBathroomCard(count);
            }),
          ),

          const SizedBox(height: 32),

          // Extras
          const Text(
            'Extras',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add on extras for a cleaning upgrade',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
            children: _extras.entries.map((entry) {
              return IconSelectionCard(
                icon: entry.value['icon'],
                label: entry.key,
                price: '\$${entry.value['price']}',
                isSelected: _selectedExtras.contains(entry.key),
                onTap: () {
                  setState(() {
                    if (_selectedExtras.contains(entry.key)) {
                      _selectedExtras.remove(entry.key);
                    } else {
                      _selectedExtras.add(entry.key);
                    }
                  });
                  _notifyDataChanged();
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 32),

          // Any Pets?
          const Text(
            'Any Pets?',
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
                child: _buildToggleButton('Yes', _hasPets, () {
                  setState(() => _hasPets = true);
                  _notifyDataChanged();
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildToggleButton('No', !_hasPets, () {
                  setState(() => _hasPets = false);
                  _notifyDataChanged();
                }),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // How do we get in?
          const Text(
            'How do we get in?',
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
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _buildAccessButton('Someone is Home'),
              _buildAccessButton('Doorman'),
              _buildAccessButton('Hidden Key'),
              _buildAccessButton('Other'),
            ],
          ),

          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'km',
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
            maxLines: 2,
            onChanged: (value) {
              _accessDescription = value;
              _notifyDataChanged();
            },
          ),

          const SizedBox(height: 32),

          // Special Notes
          const Text(
            'Special Notes or Instructions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'vill',
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
            maxLines: 4,
            onChanged: (value) {
              _specialNotes = value;
              _notifyDataChanged();
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildRoomCard(String label, int value) {
    final isSelected = _bedrooms == value;
    return GestureDetector(
      onTap: () {
        setState(() => _bedrooms = value);
        _notifyDataChanged();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
          ),
        ),
      ),
    );
  }

  Widget _buildBathroomCard(int count) {
    final isSelected = _bathrooms == count;
    return GestureDetector(
      onTap: () {
        setState(() => _bathrooms = count);
        _notifyDataChanged();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          '$count ${count == 1 ? 'Bathroom' : 'Bathrooms'}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
          label,
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

  Widget _buildAccessButton(String label) {
    final isSelected = _accessMethod == label;
    return GestureDetector(
      onTap: () {
        setState(() => _accessMethod = label);
        _notifyDataChanged();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
          ),
        ),
      ),
    );
  }
}
