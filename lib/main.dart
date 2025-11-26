import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'theme/app_colors.dart';
import 'utils/constants.dart';
import 'viewmodels/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(prefs: prefs),
      child: MaterialApp(
        title: 'ShineHub - Cleaning Services',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryGreen,
            primary: AppColors.primaryGreen,
            secondary: AppColors.lightGreen,
          ),
          scaffoldBackgroundColor: AppColors.white,
          useMaterial3: true,
        ),
        home: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            // Check if we have a valid token
            // The ViewModel checks expiration on creation
            if (viewModel.authToken != null) {
              return const HomePage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
