import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_lover_clone/firebase_options.dart';
import 'package:money_lover_clone/my_app.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
