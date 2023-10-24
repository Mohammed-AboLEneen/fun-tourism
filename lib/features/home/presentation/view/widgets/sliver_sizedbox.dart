import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {

  final double? w;
  final double? h;

  const SliverSizedBox({super.key, this.w, this.h});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: h,
        width: w,
      ),
    );
  }
}
