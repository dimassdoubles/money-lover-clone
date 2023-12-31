import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/auth/auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkAuthState() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkAuthState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const RegisterScreen();
          }

          return const Center(
            child: Text("Splash Screen"),
          );
        },
      ),
    );
  }
}
