import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldRoundedBorder extends StatelessWidget {
  final String? hint;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Icon? icon;
  final Color? textColor;
  final Color? borderColor;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  const CustomTextFieldRoundedBorder(
      {super.key,
      this.hint,
      this.padding,
      this.icon,
      this.onChanged,
      this.textColor,
      this.borderColor,
      this.controller,
      this.onTap,
      this.maxLines,
      this.minLines,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
        textInputAction: textInputAction ?? TextInputAction.next,
        onTap: onTap,
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
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
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? Colors.white.withOpacity(.7),
              ),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? Colors.white.withOpacity(.7),
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: borderColor ?? Colors.white.withOpacity(.5))),
          hintStyle: TextStyle(
              color: textColor ?? Colors.white.withOpacity(.1),
              fontSize: 20.sp),
          suffixIcon: icon,
          contentPadding: padding,
        ));
  }
}
