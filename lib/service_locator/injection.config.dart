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
    as _i6;

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
    gh.factory<_i6.AuthBloc>(() => _i6.AuthBloc(gh<_i3.AuthService>()));
    return this;
  }
}
