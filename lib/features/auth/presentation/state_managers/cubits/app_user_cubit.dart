import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/auth/auth.dart';

@LazySingleton()
class AppUserCubit extends Cubit<AppUser?> {
  AppUserCubit() : super(null);

  void set(AppUser user) {
    emit(user);
  }
}
