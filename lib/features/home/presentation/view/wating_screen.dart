import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/internet_connection.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_states.dart';

import '../../../../cores/utils/locator_manger.dart';

class WaitingScreen extends StatefulWidget {
  final void Function()? action;

  const WaitingScreen({super.key, this.action});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Colors.indigo.withLightness(.7);
    return BlocConsumer<AppMainScreenCubit, AppMainScreenStates>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                // if internet connection its init not done or the internet connection state is wifi or mobile data
                child: (LocatorManager.locator<InternetConnectionState>()
                                .connectionStatus
                                .name !=
                            'none' ||
                        LocatorManager.locator<InternetConnectionState>()
                                .finishedInit ==
                            false)
                    ? CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: SizedBox(
                                height: context.height * .3,
                                width: context.width,
                                child: Card(color: color)),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: context.height * .32,
                              child: ListView.builder(
                                itemBuilder: (context, index) => SizedBox(
                                  width: context.width * .8,
                                  child: Card(
                                    color: color,
                                  ),
                                ),
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                                height: context.height * .3,
                                width: context.width,
                                child: Card(color: color)),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: context.height * .13,
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: SizedBox(
                          height: context.height * .17,
                          width: context.width * .5,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const Text('There Is No Connection'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                      onPressed: widget.action,
                                      child: const Text(
                                        'Retry',
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ));
        },
        listener: (context, state) {});
  }
}
