import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih_hackathon/screens/auth/login_screen.dart';
import 'package:sih_hackathon/screens/home_screen.dart';
import 'package:sih_hackathon/widgets/loading.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final SharedPreferences _prefs;

  Future<void> isLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();

    final String? token = _prefs.getString("token");

    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    if (mounted) {
      if (token != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Loading(size: 50),
          SizedBox(height: 60),
          Text(
            "Wait while we fetch your data",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
