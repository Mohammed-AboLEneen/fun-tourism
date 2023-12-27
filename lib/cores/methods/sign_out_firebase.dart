import 'package:firebase_auth/firebase_auth.dart';

Future<void> signOutUser() async {
  await FirebaseAuth.instance.signOut();
}
