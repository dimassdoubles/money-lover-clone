import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowUtils {
  ShowUtils._();

  static void showLoading() {
    EasyLoading.show(
      status: 'loading...',
      dismissOnTap: false,
    );
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }

  static void showError(String message) {
    EasyLoading.showError(message);
  }

  static void showSuccess(String message) {
    EasyLoading.showSuccess(message);
  }
}
