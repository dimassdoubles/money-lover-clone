import 'package:money_lover_clone/features/auth/auth.dart';

abstract class AuthRemoteRepo {
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<AppUser> loginWithEmail({
    required String email,
    required String password,
  });
}
