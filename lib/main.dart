import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_lover_clone/firebase_options.dart';
import 'package:money_lover_clone/my_app.dart';
import 'package:money_lover_clone/service_locator/service_locator.dart';

void main() async {
  initializeDateFormatting();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();

  runApp(const MyApp());
}
