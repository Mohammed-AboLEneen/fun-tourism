import 'package:flutter/material.dart';

void customShowAlert({
  required BuildContext context,
  required String title,
  required String content,
  required void Function()? yesAction,
  required void Function()? noAction,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              ElevatedButton(
                onPressed: yesAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.indigo, // Set the background color of the button
                ),
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: noAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.indigo, // Set the background color of the button
                ),
                child: const Text('No'),
              )
            ]);
      });
}
