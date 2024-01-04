import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:money_lover_clone/features/auth/auth.dart' as auth;
import 'package:money_lover_clone/features/auth/presentation/presentation.dart';
// ignore: unused_import
import 'package:money_lover_clone/features/common/common.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
