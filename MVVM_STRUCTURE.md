# MVVM Architecture Structure

This project follows the MVVM (Model-View-ViewModel) architecture pattern.

## Folder Structure

```
lib/
├── models/              # Data models
│   ├── otp_request.dart
│   ├── otp_response.dart
│   └── user_model.dart
├── repositories/        # Data layer - API calls
│   └── auth_repository.dart
├── services/            # API service layer
│   └── api_service.dart
├── viewmodels/          # Business logic layer
│   └── auth_viewmodel.dart
├── pages/               # UI/View layer
│   ├── login_page.dart
│   ├── signup_page.dart
│   ├── otp_verification_page.dart
│   ├── home_page.dart
│   └── user_profile_page.dart
├── utils/               # Utilities and constants
│   └── constants.dart
├── theme/               # Theme and colors
│   └── app_colors.dart
├── widgets/             # Reusable widgets
│   └── logo_with_ripple.dart
└── main.dart            # App entry point
```

## API Integration

### Implemented Endpoints

1. **POST /otp/send-otp**
   - Sends OTP to email address
   - Request: `{ "email": "user@example.com" }`
   - Response: `{ "success": true, "message": "OTP sent successfully", "otp": "952852" }`

2. **GET /auth/user/{userId}**
   - Gets user data by user ID
   - Example: `/auth/user/66a1844e13c486a7ed0b25d1`

### Configuration

Update the base URL in `lib/utils/constants.dart`:
- For Android Emulator: Use `http://10.0.2.2:8081`
- For iOS Simulator: Use `http://localhost:8081`
- For Physical Device: Use your computer's IP address (e.g., `http://192.168.1.100:8081`)

## Authentication Flow

1. User enters email on Login/Signup page
2. OTP is sent via API
3. User verifies OTP on OTP Verification page
4. User enters User ID (or it's retrieved from backend)
5. User data is loaded and displayed on Home page

## State Management

The app uses the `provider` package for state management. The `AuthViewModel` manages:
- OTP sending and verification state
- User data loading state
- Error handling
- Local storage (SharedPreferences)

## Notes

- After OTP verification, you may need to enter a User ID manually if your backend doesn't return it automatically
- The User ID can be entered via a dialog that appears on the Home page
- All API calls are handled through the repository pattern for better testability and maintainability


