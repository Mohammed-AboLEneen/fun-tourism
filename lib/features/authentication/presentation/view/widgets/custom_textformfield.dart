import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {

  final String? hint;
  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final Icon? icon;

  const CustomTextField(
      {super.key,
        this.hint,
        this.padding,
        required this.controller, this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
        textInputAction: TextInputAction.next,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This Field Is Required';
          }
          return null;
        },
        controller: controller,

        style: TextStyle(
            color: Colors.black.withOpacity(.8), fontSize: 20.sp),
        decoration: InputDecoration(

            hintText: hint,
            hintStyle: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 20.sp),
            suffixIcon: icon,
            contentPadding: padding,
        )
    );
  }
}
