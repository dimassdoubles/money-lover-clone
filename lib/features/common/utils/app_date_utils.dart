import 'package:flutter/material.dart';

class AppDateUtils {
  const AppDateUtils._();

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
    }
    return onSelectedDate?.call(initialDate);
  }
}
