import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/service_locator/service_locator.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(AuthService authService)
      : _authService = authService,
        super(Initial()) {
    on<Register>(
      (event, emit) async {
        emit(Loading());

        final (result, err) = await _authService.register(
          name: event.name,
          email: event.email,
          phone: event.phone,
          password: event.password,
        );

        if (err != null) {
          emit(Error(err));
          debugPrint("Terjadi error");
        } else {
          debugPrint("Sukses registrasi");
          final userCubit = getIt.get<AppUserCubit>();
          userCubit.set(result!);
          emit(Success(appUser: result));
        }
      },
    );

    on<Login>(
      (event, emit) async {
        ShowUtils.showLoading();
        emit(Loading());

        final (result, err) = await _authService.loginWithEmail(
          email: event.email,
          password: event.password,
        );

        ShowUtils.dismissLoading();
        if (err != null) {
          ShowUtils.showError(err.message);
          emit(Error(err));
        } else {
          final userCubit = getIt.get<AppUserCubit>();
          userCubit.set(result!);
          emit(Success(appUser: result));
        }
      },
    );
  }
}
