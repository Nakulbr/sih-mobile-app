import "package:flutter/material.dart";
import "package:sih_hackathon/app.dart";
import "package:sih_hackathon/screens/register.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

