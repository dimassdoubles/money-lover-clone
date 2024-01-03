class ValidatorUtils {
  ValidatorUtils._();

  static (bool, String?) checkEmpty(
    String? value, {
    String? fieldName,
  }) {
    if (value?.isEmpty ?? true) {
      if (fieldName != null) {
        return (true, "$fieldName tidak boleh kosong");
      }
      return (true, "Tidak boleh kosong");
    }
    return (false, null);
  }

  static (bool, String?) checkIsEmail(String? value) {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return (emailRegex.hasMatch(value ?? ""), "Email tidak valid");
  }

  static (bool, String?) checkPhone(String? value) {
    final RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');

    return (phoneRegex.hasMatch(value ?? ""), "No telepon tidak valid");
  }
}
