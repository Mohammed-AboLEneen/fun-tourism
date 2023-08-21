import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../cores/utils/images.dart';
import '../../../../../cores/utils/routers.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    animation();
    futureNavigate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(

          gradient: LinearGradient(

            colors: [

              Colors.white,

              Colors.teal.withOpacity(.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
      child: Scaffold(

        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(ImagesClass.logoImage, height: MediaQuery.of(context).size.height * .3,),
              SizedBox(
                height: 30.h,
              ),
              AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: Opacity(

                        opacity: _animationController.value,
                        child: Text(
                          'Enjoy traveling anywhere you want',
                          style: TextStyle(fontSize: 25.sp,fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  void animation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define the slide animation using Tween and CurvedAnimation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();
  }

  void futureNavigate(){

    Future.delayed(const Duration(seconds: 5), () {
      context.push(RoutersCLass.loginPage);
    });
  }
}