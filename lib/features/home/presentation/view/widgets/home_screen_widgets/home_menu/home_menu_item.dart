import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? action;

  final bool isSelected;

  const MenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .078,
      child: Column(
        children: [
          const Divider(
            height: 1,
          ),
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * .075,
                width: isSelected ? MediaQuery.of(context).size.width * .7 : 0,
              ),
              Padding(
                padding: EdgeInsets.all(7.h),
                child: Row(
                  children: [
                    FaIcon(
                      icon,
                      color: Colors.black.withOpacity(.7),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(text,
                        style: TextStyle(fontSize: context.height * .033))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
