import 'package:equatable/equatable.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

abstract class TransactionState extends Equatable {}

class Initial extends TransactionState {
  @override
  List<Object?> get props => [];
}

class Loading extends TransactionState {
  @override
  List<Object?> get props => [];
}

class Error extends TransactionState {
  final Failure failure;
  Error(this.failure);

  @override
  List<Object?> get props => [
        failure,
      ];
}

class Success extends TransactionState {
  final List<Transaction>? transactionList;

  Success({
    this.transactionList,
  });

  @override
  List<Object?> get props => [
        transactionList,
      ];
}
