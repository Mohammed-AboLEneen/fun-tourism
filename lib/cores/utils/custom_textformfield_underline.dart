import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldUnderline extends StatelessWidget {
  final String? hint;
  final EdgeInsetsGeometry? padding;
  final Icon? icon;
  final Color? textColor;
  final Color? borderColor;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onTap;

  const CustomTextFieldUnderline(
      {super.key,
      this.hint,
      this.padding,
      this.icon,
      this.onChanged,
      this.textColor,
      this.borderColor,
      this.controller,
      this.onTap,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
        textInputAction: TextInputAction.next,
        controller: controller,
        onTap: onTap,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: Colors.grey,
        onChanged: onChanged,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This Field Is Required';
          }
          return null;
        },
        style: TextStyle(
          color: textColor ?? Colors.white.withOpacity(.9),
          fontSize: 20.sp,
        ),
        decoration: InputDecoration(
          hintText: hint,
          errorStyle:
              TextStyle(color: textColor ?? Colors.white.withOpacity(.7)),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: borderColor ?? Colors.white.withOpacity(.7))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: borderColor ?? Colors.white.withOpacity(.5))),
          hintStyle: TextStyle(
              color: textColor ?? Colors.white.withOpacity(.9),
              fontSize: 20.sp),
          suffixIcon: icon,
          contentPadding: padding,
        ));
  }
}
