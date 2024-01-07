import 'package:intl/intl.dart';

class CurrencyUtils {
  CurrencyUtils._();

  static String toIdr(int? amount) {
    if (amount == null) {
      return "";
    }

    NumberFormat currencyFormatter = NumberFormat('#,##0', 'id_ID');

    return currencyFormatter.format(amount);
  }
}
