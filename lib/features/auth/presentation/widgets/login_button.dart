import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  final void Function()? _onPressed;
  final AuthBloc _authBloc;
  const LoginButton({
    super.key,
    required void Function()? onPressed,
    required AuthBloc authBloc,
  })  : _onPressed = onPressed,
        _authBloc = authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is Success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UnimplementedScreen(
                title: "Dashboard",
              ),
            ),
          );
        }
      },
      child: ElevatedButton(
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
            "Masuk",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}