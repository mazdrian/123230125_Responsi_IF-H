import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/main_page.dart';
import 'services/prefs_service.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final username = await PrefsService.getUsername();
  runApp(MyTokoApp(isLoggedIn: username != null));
}

class MyTokoApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyTokoApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyToko',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: isLoggedIn ? const MainPage() : const LoginPage(),
    );
  }
}
