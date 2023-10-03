import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../cores/methods/toast.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late StreamSubscription<User?>? _authSubscription;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    _authSubscription = auth.authStateChanges().listen((User? user) {
      if (user?.emailVerified ?? false) {
        showToast(
            msg: 'Successfully Email Verification',
            bgColor: Colors.green,
            txColor: Colors.white);
        Navigator.of(context).pop();
      } else {
        showToast(msg: 'pooooo', bgColor: Colors.red, txColor: Colors.white);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          constraints: BoxConstraints(maxHeight: h * .5, minHeight: h * .2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Email Verification',
                  style: TextStyle(fontSize: h * .05),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Check Your Email Please',
                  style: TextStyle(fontSize: h * .04),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listenToAuthChanges() {}
}
