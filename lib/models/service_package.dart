class ServicePackage {
  final String id;
  final String name;
  final String description;
  final double basePrice;
  final String duration;
  final List<String> includes;

  ServicePackage({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.duration,
    required this.includes,
  });
}

// Residential Service Packages
final List<ServicePackage> residentialPackages = [
  ServicePackage(
    id: 'basic',
    name: 'Basic Cleaning',
    description: 'Essential cleaning for your home',
    basePrice: 35.00,
    duration: '2-3 hours',
    includes: ['Dusting', 'Vacuuming', 'Mopping', 'Bathroom cleaning'],
  ),
  ServicePackage(
    id: 'deep',
    name: 'Deep Cleaning',
    description: 'Thorough cleaning with attention to detail',
    basePrice: 65.00,
    duration: '4-5 hours',
    includes: ['Everything in Basic', 'Deep scrubbing', 'Inside appliances', 'Baseboards'],
  ),
  ServicePackage(
    id: 'move',
    name: 'Move-In/Move-Out',
    description: 'Intensive cleaning for empty spaces',
    basePrice: 85.00,
    duration: '5-6 hours',
    includes: ['Deep cleaning', 'Cabinet interiors', 'Window tracks', 'All surfaces'],
  ),
  ServicePackage(
    id: 'airbnb',
    name: 'Airbnb Turnover',
    description: 'Quick turnover between guests',
    basePrice: 45.00,
    duration: '2-3 hours',
    includes: ['Bed making', 'Bathroom refresh', 'Kitchen cleanup', 'Trash removal'],
  ),
];

// Hourly Service Packages
final List<ServicePackage> hourlyPackages = [
  ServicePackage(
    id: '2hrs',
    name: '2 Hours',
    description: 'Quick cleaning session',
    basePrice: 50.00,
    duration: '2 hours',
    includes: ['Flexible tasks', 'Your priorities'],
  ),
  ServicePackage(
    id: '3hrs',
    name: '3 Hours',
    description: 'Standard cleaning session',
    basePrice: 75.00,
    duration: '3 hours',
    includes: ['Flexible tasks', 'Your priorities'],
  ),
  ServicePackage(
    id: '4hrs',
    name: '4 Hours',
    description: 'Extended cleaning session',
    basePrice: 100.00,
    duration: '4 hours',
    includes: ['Flexible tasks', 'Your priorities'],
  ),
  ServicePackage(
    id: '5plus',
    name: '5+ Hours',
    description: 'Full day cleaning',
    basePrice: 125.00,
    duration: '5+ hours',
    includes: ['Flexible tasks', 'Your priorities', '€25/hr after 5 hours'],
  ),
];

// Commercial Service Packages
final List<ServicePackage> commercialPackages = [
  ServicePackage(
    id: 'small',
    name: 'Small Office',
    description: 'Up to 1000 sq ft',
    basePrice: 120.00,
    duration: '2-3 hours',
    includes: ['Desk cleaning', 'Vacuuming', 'Restroom cleaning', 'Trash removal'],
  ),
  ServicePackage(
    id: 'medium',
    name: 'Medium Office',
    description: '1000-3000 sq ft',
    basePrice: 200.00,
    duration: '3-4 hours',
    includes: ['Everything in Small', 'Conference rooms', 'Kitchen area'],
  ),
  ServicePackage(
    id: 'large',
    name: 'Large Office',
    description: '3000+ sq ft',
    basePrice: 350.00,
    duration: '5-6 hours',
    includes: ['Everything in Medium', 'Multiple floors', 'Break rooms'],
  ),
  ServicePackage(
    id: 'retail',
    name: 'Retail Store',
    description: 'Store cleaning service',
    basePrice: 180.00,
    duration: '3-4 hours',
    includes: ['Floor cleaning', 'Display dusting', 'Restrooms', 'Windows'],
  ),
  ServicePackage(
    id: 'restaurant',
    name: 'Restaurant',
    description: 'Food service cleaning',
    basePrice: 250.00,
    duration: '4-5 hours',
    includes: ['Kitchen deep clean', 'Dining area', 'Restrooms', 'Floors'],
  ),
];

// Home Organization Packages
final List<ServicePackage> homeOrgPackages = [
  ServicePackage(
    id: 'single',
    name: 'Single Room',
    description: 'Closet or garage organization',
    basePrice: 80.00,
    duration: '3-4 hours',
    includes: ['Sorting', 'Organizing', 'Labeling', 'Disposal assistance'],
  ),
  ServicePackage(
    id: 'multiple',
    name: 'Multiple Rooms',
    description: '2-3 rooms organization',
    basePrice: 150.00,
    duration: '6-8 hours',
    includes: ['Everything in Single Room', 'Multiple spaces', 'Storage solutions'],
  ),
  ServicePackage(
    id: 'whole',
    name: 'Whole Home',
    description: 'Complete home organization',
    basePrice: 300.00,
    duration: '2 days',
    includes: ['Full home assessment', 'Room-by-room organization', 'Storage planning'],
  ),
  ServicePackage(
    id: 'declutter',
    name: 'Decluttering Service',
    description: 'Help with downsizing',
    basePrice: 100.00,
    duration: '4-5 hours',
    includes: ['Item sorting', 'Donation coordination', 'Disposal assistance'],
  ),
];

// Cities/Boroughs
final List<String> availableCities = [
  'Manhattan',
  'Brooklyn',
  'Queens',
  'Bronx',
  'Staten Island',
  'Other',
];
