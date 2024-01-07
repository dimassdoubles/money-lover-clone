import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  const AppDateUtils._();

  static String displayDate(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('EEEE, dd MMMM y', 'id_ID');

    return dateFormat.format(dateTime);
  }

  static void pickDate(BuildContext context,
      {required DateTime initialDate,
      void Function(DateTime selectedDate)? onSelectedDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      onSelectedDate?.call(picked);
    } else {
      onSelectedDate?.call(initialDate);
    }
  }
}
