import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/common/common.dart';
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
      leading: SizedBox(
        width: 32,
        height: 32,
        child: Image.asset(_transaction.category.iconPath),
      ),
      title: Text(
        _transaction.category.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        AppDateUtils.displayDate(_transaction.dateTime),
      ),
      trailing: Text(
        CurrencyUtils.toIdr(_transaction.amount),
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
