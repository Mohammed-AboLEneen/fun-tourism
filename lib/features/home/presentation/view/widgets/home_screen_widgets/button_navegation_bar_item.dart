import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_states.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final int index;
  final int currentIndex;

  const CustomBottomNavigationBarItem({super.key,
    required this.icon,
    required this.onTap,
    required this.currentIndex,
    required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppMainScreenCubit, AppMainScreenStates>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery
                    .of(context)
                    .size
                    .height * .02),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.blue.withOpacity(.9),
                  width: index == currentIndex ? 15 : 0,
                  height: index == currentIndex ? 2 : 0,
                ),
                const SizedBox(
                  height: 5,
                ),
                FaIcon(
                  icon,
                  color: Colors.white.withOpacity(.5),
                ),
              ]),
            ),
          );
        });
  }
}
