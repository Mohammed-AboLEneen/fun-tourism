import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      width: MediaQuery.of(context).size.width * .6,
      child: Column(
        children: [
          const Divider(
            height: 1,
          ),
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.7),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * .075,
                width: widget.isSelected
                    ? MediaQuery.of(context).size.width * .7
                    : 0,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .02, left: 10),
                child: Row(
                  children: [
                    FaIcon(
                      widget.icon,
                      color: Colors.black.withOpacity(.7),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(widget.text, style: const TextStyle(fontSize: 20))
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
