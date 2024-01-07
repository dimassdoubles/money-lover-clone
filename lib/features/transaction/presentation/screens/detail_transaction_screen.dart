import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

class DetailTransactionScreen extends StatelessWidget {
  final Transaction _transaction;
  const DetailTransactionScreen({
    super.key,
    required Transaction transaction,
  }) : _transaction = transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTransactionScreen(
                    transaction: _transaction,
                  ),
                ),
              );
            },
            child: const Text("Edit"),
          ),
        ],
      ),
      body: Column(
        children: [
          Gap.vLarge,
          if (_transaction.image!.isNotEmpty)
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.network(
                _transaction.image!,
                fit: BoxFit.cover,
              ),
            ),
          Container(
            padding: AppPaddings.large,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _transaction.category.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Gap.vMedium,
                        if (_transaction.description!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: AppSizes.x2),
                            child: Text(_transaction.description!),
                          ),
                        Text(
                          CurrencyUtils.toIdr(_transaction.amount),
                          style: TextStyle(
                            color: _transaction.category.type ==
                                    TransactionType.expense
                                ? AppColors.error500
                                : AppColors.primary500,
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                Gap.vLarge,
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                      child: Icon(Icons.calendar_month),
                    ),
                    Text(
                      _transaction.dateTime.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap.vLarge,
          DeleteTransactionButton(transaction: _transaction),
        ],
      ),
    );
  }
}
