import 'package:equatable/equatable.dart';
import 'package:money_lover_clone/features/common/common.dart';

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
  Success();

  @override
  List<Object?> get props => [];
}
