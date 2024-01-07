import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';
import 'package:money_lover_clone/service_locator/service_locator.dart';

class DeleteTransactionButton extends StatelessWidget {
  final Transaction _transaction;
  DeleteTransactionButton({
    super.key,
    required Transaction transaction,
  }) : _transaction = transaction;

  final TransactionBloc _transactionBloc = getIt.get<TransactionBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _transactionBloc,
      listener: (context, state) {
        if (state is Success) {
          Navigator.pop(context);
        }
      },
      child: InkWell(
        onTap: () {
          _transactionBloc.add(Delete(_transaction.id));
        },
        child: Container(
          padding: AppPaddings.large,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              "Hapus transaksi",
              style: TextStyle(
                color: AppColors.error500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
