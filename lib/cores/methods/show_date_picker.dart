import 'package:flutter/material.dart';

Future<DateTime?> showDatePickerMethod(BuildContext context,
    {DateTime? dateX}) async {
  final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateX ?? DateTime.now(),
      firstDate: DateTime(
        2023,
      ),
      lastDate: DateTime(2024),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.red, // Change OK button color
              hintColor: Colors.green, // Change Cancel button color
            ),
            child: child!);
      });

  if (pickedDate != null) {
    return pickedDate;
  }

  return null;
}
