import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService _service;
  TransactionBloc(TransactionService service)
      : _service = service,
        super(Initial()) {
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
        }
      },
    );
  }
}
