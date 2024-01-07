import 'dart:io';

import 'package:money_lover_clone/features/transaction/transaction.dart';

abstract class TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final int amount;
  final TransactionCategory category;
  final String? description;
  final DateTime dateTime;
  final File? image;

  AddTransaction({
    required this.amount,
    required this.category,
    required this.dateTime,
    required this.description,
    required this.image,
  });
}

class GetTransactionList extends TransactionEvent {}

class EditTransaction extends TransactionEvent {
  final String id;
  final int? amount;
  final TransactionCategory? category;
  final String? description;
  final DateTime? dateTime;
  final File? imageFile;

  EditTransaction({
    required this.id,
    this.amount,
    this.category,
    this.description,
    this.dateTime,
    this.imageFile,
  });
}
