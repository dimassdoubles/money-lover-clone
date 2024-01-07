import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

@lazySingleton
class TransactionListCubit extends Cubit<List<Transaction>> {
  TransactionListCubit() : super([]);

  void set(List<Transaction> transactionList) {
    emit(transactionList);
  }
}
