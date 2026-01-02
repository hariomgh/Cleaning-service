import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/icon_selection_card.dart';

class ResidentialDetailsForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic>? initialData;

  const ResidentialDetailsForm({
    super.key,
    required this.onDataChanged,
    this.initialData,
  });

  @override
  State<ResidentialDetailsForm> createState() => _ResidentialDetailsFormState();
}

class _ResidentialDetailsFormState extends State<ResidentialDetailsForm> {
  String _frequency = 'One Time';
  int _bedrooms = 3;
  int _bathrooms = 5;
  Set<String> _selectedExtras = {};
  String _cleaningProducts = 'Normal';
  bool _hasPets = false;
  String _accessMethod = 'Other';
  String _accessDescription = '';
  String _specialNotes = '';

  final List<String> _frequencies = ['One Time', 'Monthly', 'Every 2 Weeks', 'Weekly'];
  
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
      _frequency = widget.initialData!['frequency'] ?? 'One Time';
      _bedrooms = widget.initialData!['bedrooms'] ?? 3;
      _bathrooms = widget.initialData!['bathrooms'] ?? 5;
      _selectedExtras = Set<String>.from(widget.initialData!['extras'] ?? []);
      _cleaningProducts = widget.initialData!['cleaningProducts'] ?? 'Normal';
      _hasPets = widget.initialData!['hasPets'] ?? false;
      _accessMethod = widget.initialData!['accessMethod'] ?? 'Other';
      _accessDescription = widget.initialData!['accessDescription'] ?? '';
      _specialNotes = widget.initialData!['specialNotes'] ?? '';
    }
  }

  void _notifyDataChanged() {
    widget.onDataChanged({
      'frequency': _frequency,
      'bedrooms': _bedrooms,
      'bathrooms': _bathrooms,
      'extras': _selectedExtras.toList(),
      'cleaningProducts': _cleaningProducts,
      'hasPets': _hasPets,
      'accessMethod': _accessMethod,
      'accessDescription': _accessDescription,
      'specialNotes': _specialNotes,
    });
  }

  double get _bedroomPrice {
    const prices = [55.0, 310.0, 370.0, 455.0, 520.0, 275.0];
    if (_bedrooms == 0) return prices[0]; // Studio
    return prices[_bedrooms];
  }

  double get _bathroomPrice {
    const prices = [35.0, 35.0, 35.0, 35.0, 130.0];
    return prices[_bathrooms - 1];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How Often?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Save by selecting a recurring cleaning plan',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 16),
          
          // Frequency tabs
          Row(
            children: _frequencies.map((freq) {
              final isSelected = _frequency == freq;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _frequency = freq);
                    _notifyDataChanged();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
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
                      freq,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
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
            childAspectRatio: 1.8,
            children: [
              _buildRoomCard('Studio', 0, '+\$55'),
              _buildRoomCard('1\nBedroom', 1, '+\$310'),
              _buildRoomCard('2\nBedrooms', 2, '+\$370'),
              _buildRoomCard('3\nBedrooms', 3, '+\$455'),
              _buildRoomCard('4\nBedrooms', 4, '+\$520'),
              _buildRoomCard('5\nBedrooms', 5, '+\$275'),
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
            childAspectRatio: 1.8,
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

          // Cleaning Products
          const Text(
            'Cleaning Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Standard cleaning products',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildToggleButton('Normal', _cleaningProducts == 'Normal', () {
                  setState(() => _cleaningProducts = 'Normal');
                  _notifyDataChanged();
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildToggleButton('Green Products', _cleaningProducts == 'Green Products', () {
                  setState(() => _cleaningProducts = 'Green Products');
                  _notifyDataChanged();
                }),
              ),
            ],
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
              hintText: 'Please describe how we can access your home',
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

  Widget _buildRoomCard(String label, int value, String price) {
    final isSelected = _bedrooms == value;
    return GestureDetector(
      onTap: () {
        setState(() => _bedrooms = value);
        _notifyDataChanged();
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primaryCyan : AppColors.mediumGray,
              ),
            ),
          ],
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
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightCyan : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
              ),
            ),
            Text(
              count == 1 ? 'Bathroom' : 'Bathrooms',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primaryCyan : AppColors.darkText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '+\$${count == 5 ? 130 : 35}',
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primaryCyan : AppColors.mediumGray,
              ),
            ),
          ],
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
