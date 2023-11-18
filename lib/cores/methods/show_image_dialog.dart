import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

void showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            imageUrl,
            width: context.width * .8,
            height: context.height * .5,
            fit: BoxFit.cover,
          ),
        ), // Replace with your desired image widget
      );
    },
  );
}
