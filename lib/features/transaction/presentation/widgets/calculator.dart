import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';

class Calculator extends StatelessWidget {
  const Calculator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 250, // perbaris 50
      child: Row(
        children: [
          const Column(
            children: [
              _CalculatorButton(
                label: "C",
                isBold: true,
                backgroundColor: AppColors.neutral100,
              ),
              _CalculatorButton(
                label: "7",
              ),
              _CalculatorButton(
                label: "4",
              ),
              _CalculatorButton(
                label: "1",
              ),
              _CalculatorButton(
                label: "0",
              ),
            ],
          ),
          const Column(
            children: [
              _CalculatorButton(
                label: "÷",
                isBold: true,
                backgroundColor: AppColors.neutral100,
              ),
              _CalculatorButton(
                label: "8",
              ),
              _CalculatorButton(
                label: "5",
              ),
              _CalculatorButton(
                label: "2",
              ),
              _CalculatorButton(
                label: "000",
              ),
            ],
          ),
          const Column(
            children: [
              _CalculatorButton(
                label: "×",
                isBold: true,
                backgroundColor: AppColors.neutral100,
              ),
              _CalculatorButton(
                label: "9",
              ),
              _CalculatorButton(
                label: "6",
              ),
              _CalculatorButton(
                label: "3",
              ),
              _CalculatorButton(
                label: ".",
              ),
            ],
          ),
          Column(
            children: [
              const _CalculatorButton(
                label: "⌫",
                isBold: true,
                backgroundColor: AppColors.neutral100,
              ),
              const _CalculatorButton(
                label: "−",
                isBold: true,
                backgroundColor: AppColors.neutral100,
              ),
              const _CalculatorButton(
                label: "+",
                isBold: true,
                backgroundColor: AppColors.neutral100,
              ),
              Container(
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
  final bool _isBold;
  const _CalculatorButton({
    required String label,
    void Function()? onTap,
    Color? backgroundColor,
    bool isBold = false,
  })  : _label = label,
        _onTap = onTap,
        _backgroundColor = backgroundColor,
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
              color: AppColors.primary500,
              fontWeight: _isBold ? FontWeight.bold : null,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
