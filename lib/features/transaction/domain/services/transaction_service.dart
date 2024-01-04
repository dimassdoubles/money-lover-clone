import 'dart:io';

import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

abstract class TransactionService {
  Future<(void, Failure?)> addTransaction({
    required int amount,
    required TransactionCategory category,
    required DateTime dateTime,
    String? description,
    File? image,
  });

  Future<(List<Transaction>?, Failure?)> getTransactionList();

  Future<(void, Failure?)> editTransaction({
    required String id,
    int? amount,
    TransactionCategory? category,
    String? description,
    DateTime? dateTime,
    File? imageFile,
  });
}
