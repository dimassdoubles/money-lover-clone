import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';

enum _Operator {
  divider("÷"),
  multiplier("×"),
  adder("+"),
  deduction("-");

  const _Operator(this.symbol);
  final String symbol;
}

class Calculator extends StatefulWidget {
  final void Function(int amount)? _onValueChanged;
  final TextEditingController? _controller;
  const Calculator({
    super.key,
    void Function(int amount)? onValueChanged,
    TextEditingController? controller,
  })  : _onValueChanged = onValueChanged,
        _controller = controller;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  _Operator? operator;
  int? number1;
  int? number2;

  void _typingNumber(String number) {
    debugPrint("_typingNumber $number");
    if (operator == null) {
      number1 = int.parse("${number1 ?? ""}$number");
    } else {
      number2 = int.parse("${number2 ?? ""}$number");
    }

    _setDisplayText();
    debugPrint("number1 $number1");
    debugPrint("number2 $number2");
    widget._onValueChanged?.call(0);
  }

  void _selectOperator(_Operator selected) {
    setState(() {
      if (operator == selected && number2 == null) {
        operator = null;
      } else {
        operator = selected;
      }

      _setDisplayText();
    });
  }

  void _getResult() {
    final int result;
    switch (operator) {
      case _Operator.divider:
        result = number1! ~/ number2!;
        break;
      case _Operator.multiplier:
        result = number1! * number2!;
        break;
      case _Operator.deduction:
        result = number1! - number2!;
        break;
      case _Operator.adder:
        result = number1! + number2!;
        break;
      case null:
        result = 0;
    }

    setState(() {
      number1 = result;
      number2 = null;
      operator = null;
      _setDisplayText();
    });
  }

  void _clear() {
    // setState(() {
    number1 = null;
    number2 = null;
    operator = null;

    setState(() {
      _setDisplayText();
    });
  }

  void _delete() {
    if (operator != null && number2 != null) {
      final String number2String = number2.toString();
      final String number2StringDeleted =
          number2String.substring(0, number2String.length - 1);

      if (number2StringDeleted.isEmpty) {
        number2 = null;
      } else {
        number2 = int.parse(number2StringDeleted);
      }
    } else if (operator != null) {
      setState(() {});
      operator = null;
    } else {
      final String number1String = number1.toString();
      final String number1StringDeleted =
          number1String.substring(0, number1String.length - 1);

      if (number1StringDeleted.isEmpty) {
        number1 = null;
      } else {
        number1 = int.parse(number1StringDeleted);
      }
    }

    _setDisplayText();
  }

  void _setDisplayText() {
    widget._controller?.text =
        "${number1 ?? ""} ${operator?.symbol ?? ""} ${number2 ?? " "}".trim();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 250, // perbaris 50
      child: Row(
        children: [
          Column(
            children: [
              _CalculatorButton(
                label: "C",
                isBold: true,
                backgroundColor: AppColors.neutral100,
                onTap: () {
                  _clear();
                },
              ),
              _CalculatorButton(
                label: "7",
                onTap: () {
                  _typingNumber("7");
                },
              ),
              _CalculatorButton(
                label: "4",
                onTap: () {
                  _typingNumber("4");
                },
              ),
              _CalculatorButton(
                label: "1",
                onTap: () {
                  _typingNumber("1");
                },
              ),
              _CalculatorButton(
                label: "0",
                onTap: () {
                  _typingNumber("0");
                },
              ),
            ],
          ),
          Column(
            children: [
              _CalculatorButton(
                label: "÷",
                isBold: true,
                backgroundColor: operator == _Operator.divider
                    ? AppColors.primary500
                    : AppColors.neutral100,
                color: operator == _Operator.divider
                    ? Colors.white
                    : AppColors.primary500,
                onTap: () {
                  _selectOperator(_Operator.divider);
                },
              ),
              _CalculatorButton(
                label: "8",
                onTap: () {
                  _typingNumber("8");
                },
              ),
              _CalculatorButton(
                label: "5",
                onTap: () {
                  _typingNumber("5");
                },
              ),
              _CalculatorButton(
                label: "2",
                onTap: () {
                  _typingNumber("2");
                },
              ),
              _CalculatorButton(
                label: "000",
                onTap: () {
                  _typingNumber("000");
                },
              ),
            ],
          ),
          Column(
            children: [
              _CalculatorButton(
                label: "×",
                isBold: true,
                backgroundColor: operator == _Operator.multiplier
                    ? AppColors.primary500
                    : AppColors.neutral100,
                color: operator == _Operator.multiplier
                    ? Colors.white
                    : AppColors.primary500,
                onTap: () {
                  _selectOperator(_Operator.multiplier);
                },
              ),
              _CalculatorButton(
                label: "9",
                onTap: () {
                  _typingNumber("9");
                },
              ),
              _CalculatorButton(
                label: "6",
                onTap: () {
                  _typingNumber("6");
                },
              ),
              _CalculatorButton(
                label: "3",
                onTap: () {
                  _typingNumber("3");
                },
              ),
              const _CalculatorButton(
                label: ".",
              ),
            ],
          ),
          Column(
            children: [
              _CalculatorButton(
                label: "⌫",
                isBold: true,
                backgroundColor: AppColors.neutral100,
                onTap: () {
                  _delete();
                },
              ),
              _CalculatorButton(
                label: "−",
                isBold: true,
                backgroundColor: operator == _Operator.deduction
                    ? AppColors.primary500
                    : AppColors.neutral100,
                color: operator == _Operator.deduction
                    ? Colors.white
                    : AppColors.primary500,
                onTap: () {
                  _selectOperator(_Operator.deduction);
                },
              ),
              _CalculatorButton(
                label: "+",
                isBold: true,
                backgroundColor: operator == _Operator.adder
                    ? AppColors.primary500
                    : AppColors.neutral100,
                color: operator == _Operator.adder
                    ? Colors.white
                    : AppColors.primary500,
                onTap: () {
                  _selectOperator(_Operator.adder);
                },
              ),
              InkWell(
                onTap: () {
                  if (operator != null && number2 != null) {
                    _getResult();
                  }
                },
                child: Container(
                  width: 0.25.sw,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary500,
                    border: Border.all(
                      color: AppColors.neutral300,
                      width: 0.5,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "=",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalculatorButton extends StatelessWidget {
  final String _label;
  final void Function()? _onTap;
  final Color? _backgroundColor;
  final Color _color;
  final bool _isBold;
  const _CalculatorButton({
    required String label,
    void Function()? onTap,
    Color? backgroundColor,
    Color color = AppColors.primary500,
    bool isBold = false,
  })  : _label = label,
        _onTap = onTap,
        _backgroundColor = backgroundColor,
        _color = color,
        _isBold = isBold;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        width: 0.25.sw,
        height: 50,
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: Border.all(
            color: AppColors.neutral300,
            width: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            _label,
            style: TextStyle(
              color: _color,
              fontWeight: _isBold ? FontWeight.bold : null,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
