import 'package:flutter/material.dart';

class UnimplementedScreen extends StatelessWidget {
  final String title;
  const UnimplementedScreen({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(title)),
    );
  }
}
