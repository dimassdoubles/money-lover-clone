import 'package:equatable/equatable.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

class Transaction extends Equatable {
  final String id;
  final int amount;
  final TransactionCategory category;
  final String? description;
  final DateTime dateTime;
  final String? image;

  const Transaction({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.dateTime,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        amount,
        category,
        description,
        dateTime,
        image,
      ];
}
