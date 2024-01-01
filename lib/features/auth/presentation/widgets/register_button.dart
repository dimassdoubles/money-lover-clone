import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';

class RegisterButton extends StatelessWidget {
  final void Function()? _onPressed;
  const RegisterButton({
    super.key,
    required void Function()? onPressed,
  }) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        
        _onPressed?.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.neutral100,
        elevation: 0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.x3),
        width: 1.sw,
        child: const Text(
          "Daftar",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
