import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

@LazySingleton(as: TransactionService)
class FirebaseTransactionService implements TransactionService {
  final TransactionRemoteRepo _remoteRepo;

  FirebaseTransactionService(TransactionRemoteRepo remoteRepo)
      : _remoteRepo = remoteRepo;

  @override
  Future<(void, Failure?)> addTransaction({
    required int amount,
    required TransactionCategory category,
    required DateTime dateTime,
    String? description,
    File? image,
  }) async {
    return await ServiceUtils.handleFailure<void>(() async {
      return await _remoteRepo.addTransaction(
        amount: amount,
        category: category,
        dateTime: dateTime,
        description: description,
        image: image,
      );
    });
  }

  @override
  Future<(void, Failure?)> editTransaction(
      {required String id,
      int? amount,
      TransactionCategory? category,
      String? description,
      DateTime? dateTime,
      File? imageFile}) {
    // TODO: implement editTransaction
    throw UnimplementedError();
  }

  @override
  Future<(List<Transaction>?, Failure?)> getTransactionList() {
    // TODO: implement getTransactionList
    throw UnimplementedError();
  }
}