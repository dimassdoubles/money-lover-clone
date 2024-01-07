import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

class EditTransactionButton extends StatelessWidget {
  const EditTransactionButton({
    super.key,
    required String transactionId,
    required this.amount,
    required this.transactionCategory,
    required TransactionBloc transactionBloc,
    required this.dateTime,
    required TextEditingController descCtrlr,
    required this.imageFile,
  })  : _transactionBloc = transactionBloc,
        _descCtrlr = descCtrlr,
        _transactionId = transactionId;

  final String _transactionId;
  final int? amount;
  final TransactionCategory? transactionCategory;
  final TransactionBloc _transactionBloc;
  final DateTime dateTime;
  final TextEditingController _descCtrlr;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _transactionBloc,
      listener: (context, state) {
        if (state is Success) {
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: AppPaddings.large,
        child: ElevatedButton(
          onPressed: () {
            if (amount != null && transactionCategory != null) {
              FocusScope.of(context).unfocus();
              debugPrint("sampai sini bro");
              debugPrint("disini nih");

              debugPrint("${transactionCategory?.name}");

              _transactionBloc.add(
                EditTransaction(
                  id: _transactionId,
                  amount: amount!,
                  category: transactionCategory,
                  dateTime: dateTime,
                  description: _descCtrlr.text,
                  imageFile: imageFile,
                ),
              );

              debugPrint("sampai sini bro");
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (amount == null && transactionCategory == null)
                ? AppColors.neutral200
                : AppColors.primary500,
            foregroundColor: (amount == null && transactionCategory == null)
                ? AppColors.neutral300
                : AppColors.neutral100,
            elevation: 0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.x3),
            width: 1.sw,
            child: const Text(
              "Simpan",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
