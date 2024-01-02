import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/service_locator/service_locator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthBloc _authBloc = getIt.get<AuthBloc>();

  final TextEditingController _nameCtrlr = TextEditingController();
  final TextEditingController _emailCtrlr = TextEditingController();
  final TextEditingController _phoneCtrlr = TextEditingController();
  final TextEditingController _passwordCtrlr = TextEditingController();
  final TextEditingController _passwordConfirmCtrlr = TextEditingController();

  @override
  void dispose() {
    _nameCtrlr.dispose();
    _emailCtrlr.dispose();
    _phoneCtrlr.dispose();
    _passwordCtrlr.dispose();
    _passwordConfirmCtrlr.dispose();
    super.dispose();
  }

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
                _InputText(
                  controller: _nameCtrlr,
                  hintText: "Nama",
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                ),
                Gap.vLarge,
                _InputText(
                  controller: _emailCtrlr,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap.vLarge,
                _InputText(
                  controller: _phoneCtrlr,
                  hintText: "No telepon",
                  keyboardType: TextInputType.phone,
                ),
                Gap.vLarge,
                _InputPassword(
                  controller: _passwordCtrlr,
                  hintText: "Kata sandi",
                ),
                Gap.vLarge,
                _InputPassword(
                  controller: _passwordConfirmCtrlr,
                  hintText: "Konfirmasi kata sandi",
                ),
                Gap.vLarge,
                Gap.vLarge,
                RegisterButton(
                  authBloc: _authBloc,
                  onPressed: () {
                    _authBloc.add(
                      Register(
                        name: _nameCtrlr.text,
                        email: _emailCtrlr.text,
                        phone: _phoneCtrlr.text,
                        password: _passwordCtrlr.text,
                      ),
                    );
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
        controller: _controller,
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
  final TextEditingController _controller;
  const _InputPassword({
    Key? key,
    String? hintText,
    required TextEditingController controller,
  })  : _hintText = hintText,
        _key = key,
        _controller = controller;

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
