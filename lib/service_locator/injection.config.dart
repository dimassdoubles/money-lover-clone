// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:money_lover_clone/features/auth/auth.dart' as _i3;
import 'package:money_lover_clone/features/auth/data/repositories/remote/firebase_auth_repo.dart'
    as _i4;
import 'package:money_lover_clone/features/auth/data/services/firebase_auth_service.dart'
    as _i5;
import 'package:money_lover_clone/features/auth/presentation/state_managers/blocs/auth_bloc.dart'
    as _i10;
import 'package:money_lover_clone/features/transaction/data/repositories/remote/firebase_remote_repo.dart'
    as _i7;
import 'package:money_lover_clone/features/transaction/data/repositories/remote/transaction_remote_repo.dart'
    as _i6;
import 'package:money_lover_clone/features/transaction/data/services/firebase_transaction_service.dart'
    as _i9;
import 'package:money_lover_clone/features/transaction/presentation/state_managers/blocs/transaction_bloc.dart'
    as _i11;
import 'package:money_lover_clone/features/transaction/transaction.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthRemoteRepo>(() => _i4.FirebaseAuthRepo());
    gh.lazySingleton<_i3.AuthService>(
        () => _i5.FirebaseAuthService(gh<_i3.AuthRemoteRepo>()));
    gh.lazySingleton<_i6.TransactionRemoteRepo>(() => _i7.FirebaseRemoteRepo());
    gh.lazySingleton<_i8.TransactionService>(
        () => _i9.FirebaseTransactionService(gh<_i6.TransactionRemoteRepo>()));
    gh.factory<_i10.AuthBloc>(() => _i10.AuthBloc(gh<_i3.AuthService>()));
    gh.factory<_i11.TransactionBloc>(
        () => _i11.TransactionBloc(gh<_i8.TransactionService>()));
    return this;
  }
}
