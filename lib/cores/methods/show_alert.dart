import 'package:flutter/material.dart';

void customShowAlert({

  required BuildContext context,
  required String title,
  required String content,
  required void Function()? action,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("Email Verification"),
            content: const Text("Check Your Email Please"),
            actions: [

              ElevatedButton(
                onPressed: action,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.teal, // Set the background color of the button
                ),
                child: const Text('Done'),
              ),
            ]
        );
      });
}