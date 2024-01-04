import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:money_lover_clone/features/auth/auth.dart' as auth;
// ignore: unused_import
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/presentation/screens/add_transaction_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AddTransactionScreen(),
        );
      },
    );
  }
}
