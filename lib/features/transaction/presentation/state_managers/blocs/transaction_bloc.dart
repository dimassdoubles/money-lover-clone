import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';
import 'package:money_lover_clone/service_locator/service_locator.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService _service;
  TransactionBloc(TransactionService service)
      : _service = service,
        super(Initial()) {
    on<Delete>(
      (event, emit) async {
        debugPrint("bloc delete");
        ShowUtils.showLoading();
        emit(Loading());

        final (_, err) = await _service.delete(event.id);

        if (err != null) {
          ShowUtils.showError("Gagal menghapus transaksi");
          emit(Error(err));
        } else {
          ShowUtils.showSuccess("Berhasil menghapus transaksi");
          emit(Success());

          add(GetTransactionList());
        }
      },
    );
    on<EditTransaction>(
      (event, emit) async {
        debugPrint("Edit transaksi bloc dipanggil");
        ShowUtils.showLoading();
        emit(Loading());

        debugPrint("sampai transaksi bloc");
        debugPrint("bloc ${event.category?.name}");

        final (_, err) = await _service.editTransaction(
          id: event.id,
          amount: event.amount,
          category: event.category,
          dateTime: event.dateTime,
          description: event.description,
          imageFile: event.imageFile,
        );

        if (err != null) {
          ShowUtils.showError("Gagal mengedit transaksi");
          emit(Error(err));
        } else {
          ShowUtils.showSuccess("Berhasil mengedit transaksi");
          emit(Success());

          add(GetTransactionList());
        }
      },
    );
    on<GetTransactionList>(
      (event, emit) async {
        final TransactionListCubit transactionListCubit =
            getIt.get<TransactionListCubit>();
        emit(Loading());

        final (result, err) = await _service.getTransactionList();

        if (err != null) {
          ShowUtils.showError(err.message);
          emit(Error(err));
        } else {
          emit(Success(transactionList: result));
          transactionListCubit.set(result!);
        }
      },
    );

    on<AddTransaction>(
      (event, emit) async {
        ShowUtils.showLoading();
        emit(Loading());

        final (_, err) = await _service.addTransaction(
          amount: event.amount,
          category: event.category,
          dateTime: event.dateTime,
          description: event.description,
          image: event.image,
        );

        if (err != null) {
          ShowUtils.showError(err.message);
          emit(Error(err));
        } else {
          ShowUtils.showSuccess("Berhasil membuat transaksi baru");
          emit(Success());

          add(GetTransactionList());
        }
      },
    );
  }
}
