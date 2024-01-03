import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/service_locator/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc _authBloc = getIt.get<AuthBloc>();

  final TextEditingController _emailCtrlr = TextEditingController();
  final TextEditingController _passwordCtrlr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCtrlr.dispose();
    _passwordCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: AppPaddings.large,
          child: Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SafeArea(
                        child: Center(
                          child: Text(
                            "Masuk",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Gap.vLarge,
                      Gap.vLarge,
                      _InputText(
                        controller: _emailCtrlr,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final (isEmpty, messageEmpty) =
                              ValidatorUtils.checkEmpty(
                            value,
                            fieldName: "Email",
                          );

                          final (isEmail, messageEmail) =
                              ValidatorUtils.checkIsEmail(value);

                          if (isEmpty) {
                            return messageEmpty;
                          } else if (!isEmail) {
                            return messageEmail;
                          }

                          return null;
                        },
                      ),
                      Gap.vLarge,
                      _InputPassword(
                        controller: _passwordCtrlr,
                        hintText: "Kata sandi",
                        validator: (value) {
                          final (isEmpty, messageEmpty) =
                              ValidatorUtils.checkEmpty(
                            value,
                            fieldName: "Kata sandi",
                          );

                          if (isEmpty) {
                            return messageEmpty;
                          }

                          return null;
                        },
                      ),
                      Gap.vLarge,
                    ],
                  ),
                ),
              ),
              Gap.vLarge,
              LoginButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _authBloc.add(
                      Login(
                        email: _emailCtrlr.text,
                        password: _passwordCtrlr.text,
                      ),
                    );
                  }
                },
                authBloc: _authBloc,
              ),
              Gap.vLarge,
              Wrap(
                runAlignment: WrapAlignment.center,
                children: [
                  const Text("Belum punya akun ?"),
                  Gap.hSmall,
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Daftar di sini",
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
  final TextEditingController _controller;
  const _InputText({
    Key? key,
    String? Function(String?)? validator,
    String? hintText,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obsecure = false,
    Widget? suffix,
    required TextEditingController controller,
  })  : _hintText = hintText,
        _key = key,
        _validator = validator,
        _keyboardType = keyboardType,
        _textCapitalization = textCapitalization,
        _obsecure = obsecure,
        _suffix = suffix,
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _key,
      validator: _validator,
      keyboardType: _keyboardType,
      textCapitalization: _textCapitalization,
      obscureText: _obsecure,
      controller: _controller,
      decoration: InputDecoration(
        hintText: _hintText,
        filled: true,
        fillColor: AppColors.neutral100,
        hintStyle: const TextStyle(
          color: AppColors.neutral300,
        ),
        suffix: _suffix,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.neutral100,
          ),
          borderRadius: AppBorderRadiuses.medium,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary500,
          ),
          borderRadius: AppBorderRadiuses.medium,
        ),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadiuses.medium,
        ),
      ),
    );
  }
}

class _InputPassword extends StatefulWidget {
  final Key? _key;
  final String? _hintText;
  final TextEditingController _controller;
  final String? Function(String?)? _validator;
  const _InputPassword({
    Key? key,
    String? hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  })  : _hintText = hintText,
        _key = key,
        _controller = controller,
        _validator = validator;

  @override
  State<_InputPassword> createState() => __InputPasswordState();
}

class __InputPasswordState extends State<_InputPassword> {
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return _InputText(
      key: widget._key,
      controller: widget._controller,
      hintText: widget._hintText,
      obsecure: obsecure,
      validator: widget._validator,
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
