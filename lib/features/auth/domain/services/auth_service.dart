import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';

abstract class AuthService {
  Future<(bool?, Failure?)> isLoggedIn();

  Future<(AppUser?, Failure?)> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<(AppUser?, Failure?)> loginWithEmail({
    required String email,
    required String password,
  });
}
