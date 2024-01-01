import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: AppPaddings.large,
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap.vLarge,
                Gap.vLarge,
                const _InputText(
                  hintText: "Nama",
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                ),
                Gap.vLarge,
                const _InputText(
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap.vLarge,
                const _InputText(
                  hintText: "No telepon",
                  keyboardType: TextInputType.phone,
                ),
                Gap.vLarge,
                const _InputPassword(hintText: "Kata sandi"),
                Gap.vLarge,
                const _InputPassword(
                  hintText: "Konfirmasi kata sandi",
                ),
                Gap.vLarge,
                Gap.vLarge,
                RegisterButton(
                  onPressed: () {
                    // TODO : register logic
                  },
                ),
                Gap.vLarge,
                Wrap(
                  runAlignment: WrapAlignment.center,
                  children: [
                    const Text("Sudah punya akun ?"),
                    Gap.hSmall,
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Login di sini",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputText extends StatelessWidget {
  final Key? _key;
  final String? _hintText;
  final String? Function(String?)? _validator;
  final TextInputType? _keyboardType;
  final TextCapitalization _textCapitalization;
  final bool _obsecure;
  final Widget? _suffix;
  const _InputText({
    Key? key,
    String? Function(String?)? validator,
    String? hintText,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obsecure = false,
    Widget? suffix,
  })  : _hintText = hintText,
        _key = key,
        _validator = validator,
        _keyboardType = keyboardType,
        _textCapitalization = textCapitalization,
        _obsecure = obsecure,
        _suffix = suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.x1,
        horizontal: AppSizes.x4,
      ),
      decoration: BoxDecoration(
          color: AppColors.neutral100, borderRadius: AppBorderRadiuses.medium),
      child: TextFormField(
        key: _key,
        validator: _validator,
        keyboardType: _keyboardType,
        textCapitalization: _textCapitalization,
        obscureText: _obsecure,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: const TextStyle(
            color: AppColors.neutral300,
          ),
          suffix: _suffix,
        ),
      ),
    );
  }
}

class _InputPassword extends StatefulWidget {
  final Key? _key;
  final String? _hintText;
  const _InputPassword({
    Key? key,
    String? hintText,
  })  : _hintText = hintText,
        _key = key;

  @override
  State<_InputPassword> createState() => __InputPasswordState();
}

class __InputPasswordState extends State<_InputPassword> {
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return _InputText(
      key: widget._key,
      hintText: widget._hintText,
      obsecure: obsecure,
      suffix: GestureDetector(
        onTap: () {
          setState(() {
            obsecure = !obsecure;
          });
        },
        child: Icon(
          obsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
      ),
    );
  }
}
