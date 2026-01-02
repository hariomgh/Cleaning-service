import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/booking_viewmodel.dart';
import '../widgets/category_card.dart';
import '../widgets/filter_chip_widget.dart';
import 'booking_page.dart';
import 'user_profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFilter = 'New';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final viewModel = Provider.of<AuthViewModel>(context, listen: false);
    final userId = viewModel.getSavedUserId();
    if (userId != null) {
      viewModel.getUserData(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            final user = viewModel.currentUser;
            final userName = user?.name ?? 'User';
            final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '👋',
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfilePage(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.primaryGreen,
                          child: Text(
                            userInitial,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('New'),
                        _buildFilterChip('Trending'),
                        _buildFilterChip('Popular'),
                        _buildFilterChip('Top rated'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Promotional Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDE68A), // Yellowish color from design
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Limited offer',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              '40% OFF',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'On your first ShineHub cleaning.',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BookingPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.black,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Book now'),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: 20,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.cleaning_services,
                              size: 50,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // All Categories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            color: AppColors.gray,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        CategoryCard(
                          title: 'Home Cleaning',
                          subtitle: 'Standard & deep',
                          icon: Image.asset(
                            'assets/home_cleaning.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.home, size: 40, color: Color(0xFF4CAF50)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.residential,
                                ),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: 'Airbnb',
                          subtitle: 'Guest turnover',
                          icon: Image.asset(
                            'assets/airbnb.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.hotel, size: 40, color: Color(0xFF2196F3)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.residential,
                                ),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: 'Office',
                          subtitle: 'Workspaces',
                          icon: Image.asset(
                            'assets/office.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.business, size: 40, color: Color(0xFFFF9800)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.commercial,
                                ),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: 'Windows',
                          subtitle: 'Inside & out',
                          icon: Image.asset(
                            'assets/windows.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.window, size: 40, color: Color(0xFF9C27B0)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.residential,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Other Services - Booking Types
                  const Text(
                    'Booking Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        CategoryCard(
                          title: 'Residential',
                          subtitle: 'Standard & deep',
                          icon: const Icon(
                            Icons.home,
                            size: 40,
                            color: Color(0xFF4CAF50), // Green
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.residential,
                                ),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: 'Hourly',
                          subtitle: 'Flexible hours',
                          icon: const Icon(
                            Icons.access_time,
                            size: 40,
                            color: Color(0xFF2196F3), // Blue
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.hourly,
                                ),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: 'Commercial',
                          subtitle: 'Business spaces',
                          icon: const Icon(
                            Icons.business,
                            size: 40,
                            color: Color(0xFFFF9800), // Orange
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.commercial,
                                ),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: 'Home Org',
                          subtitle: 'Declutter & organize',
                          icon: const Icon(
                            Icons.inventory_2,
                            size: 40,
                            color: Color(0xFF9C27B0), // Purple
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(
                                  initialBookingType: BookingType.homeOrganization,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChipWidget(
      label: label,
      isSelected: _selectedFilter == label,
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
    );
  }
}
