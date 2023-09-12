import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final EdgeInsetsGeometry? padding;
  final Icon? icon;
  final void Function(String)? onChanged;

  const CustomTextField(
      {super.key, this.hint, this.padding, this.icon, this.onChanged});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
        textInputAction: TextInputAction.next,
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
          color: Colors.white.withOpacity(.9),
          fontSize: 20.sp,
        ),
        decoration: InputDecoration(
          hintText: hint,
          errorStyle: TextStyle(color: Colors.white.withOpacity(.7)),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(.5))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(.5))),
          hintStyle:
              TextStyle(color: Colors.white.withOpacity(.9), fontSize: 20.sp),
          suffixIcon: icon,
          contentPadding: padding,
        ));
  }
}
