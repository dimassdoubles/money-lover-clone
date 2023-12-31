import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/auth/auth.dart' as auth;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth.SplashScreen(),
    );
  }
}
