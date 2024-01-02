import 'package:injectable/injectable.dart';
import 'package:money_lover_clone/features/auth/auth.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/common/domain/models/failure.dart';

@LazySingleton(as: AuthService)
class FirebaseAuthService implements AuthService {
  final AuthRemoteRepo _remoteRepo;

  FirebaseAuthService(AuthRemoteRepo remoteRepo) : _remoteRepo = remoteRepo;

  @override
  Future<(bool?, Failure?)> isLoggedIn() async {
    return Future(() => const (false, Failure()));
  }

  @override
  Future<(AppUser?, Failure?)> loginWithEmail({
    required String email,
    required String password,
  }) {
    return Future(() => const (null, Failure()));
  }

  @override
  Future<(AppUser?, Failure?)> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    return await ServiceUtils.handleFailure<AppUser>(() async {
      return await _remoteRepo.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
    });
  }
}
