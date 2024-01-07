import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/common/constants/app_colors.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction _transaction;
  const TransactionItem({
    super.key,
    required Transaction transaction,
  }) : _transaction = transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailTransactionScreen(transaction: _transaction),
          ),
        );
      },
      title: Text(_transaction.category.name),
      subtitle: Text(
        _transaction.dateTime.toString(),
      ),
      trailing: Text(
        "${_transaction.amount}",
        style: TextStyle(
          fontSize: 20,
          color: _transaction.category.type == TransactionType.expense
              ? AppColors.error500
              : AppColors.primary500,
        ),
      ),
    );
  }
}
