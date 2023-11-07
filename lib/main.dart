import 'package:card_board/constants/strings.dart';
import 'package:card_board/home/view/home_view.dart';
import 'package:card_board/login/view/login_view.dart';
import 'package:card_board/services/locator.dart';
import 'package:card_board/services/preference_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  PreferenceService preferenceService = PreferenceService(getIt());

  bool isLoggedIn = preferenceService.isUserLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: ThemeData(),
      home: isLoggedIn ? const HomeView() : const LoginView(),
    );
  }
}
