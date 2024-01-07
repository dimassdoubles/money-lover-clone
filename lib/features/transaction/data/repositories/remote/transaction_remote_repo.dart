import 'dart:io';
import 'package:money_lover_clone/features/transaction/transaction.dart';

abstract class TransactionRemoteRepo {
  Future<void> addTransaction({
    required int amount,
    required TransactionCategory category,
    required DateTime dateTime,
    String? description,
    File? image,
  });

  Future<List<Transaction>> getTransactionList();

  Future<void> editTransaction({
    required String id,
    int? amount,
    TransactionCategory? category,
    String? description,
    DateTime? dateTime,
    File? imageFile,
  });
}
