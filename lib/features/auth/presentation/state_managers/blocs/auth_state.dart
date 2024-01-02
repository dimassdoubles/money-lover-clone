import 'package:equatable/equatable.dart';
import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';

abstract class AuthState extends Equatable {}

class Initial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Error extends AuthState {
  final Failure failure;
  Error(this.failure);

  @override
  List<Object?> get props => [
        failure,
      ];
}

class Success extends AuthState {
  final AppUser? appUser;

  Success({
    this.appUser,
  });

  @override
  List<Object?> get props => [
        appUser,
      ];
}
