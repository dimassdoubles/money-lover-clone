import 'package:money_lover_clone/features/common/common.dart';

class ServiceUtils {
  ServiceUtils._();

  static Future<(SuccessType?, Failure?)> handleFailure<SuccessType>(
      Future<SuccessType> Function() repoExecutor) async {
    try {
      final result = await repoExecutor();
      return (result, null);
    } catch (e) {
      return const (null, Failure());
    }
  }
}
