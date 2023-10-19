import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class MenuItem extends StatefulWidget {
  final String text;
  final IconData icon;

  final bool isSelected;

  const MenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
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
                width: widget.isSelected
                    ? MediaQuery.of(context).size.width * .7
                    : 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FaIcon(
                      widget.icon,
                      color: Colors.black.withOpacity(.7),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(widget.text,
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
