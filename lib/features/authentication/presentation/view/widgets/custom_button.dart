import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class CustomIcon extends StatelessWidget {

  const CustomIcon({super.key,required this.widget, this.tap});


  final void Function()? tap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(

      borderRadius: BorderRadius.circular(70),
      color: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,

      child: InkWell(

        borderRadius: BorderRadius.circular(20),
        onTap: tap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(

            child: widget,
          ),
        ),
      ),
    );
  }
}
