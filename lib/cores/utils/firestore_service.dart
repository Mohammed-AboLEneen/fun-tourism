import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../methods/toast.dart';

class FireStoreServices {
  static var usersCollection = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getUserData({required String email}) async {
    return await usersCollection.doc(email).get();
  }

  static Future<bool> checkUserDataExist({required email}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await usersCollection.where(email).get();

    if (querySnapshot.docs.isEmpty) {
      showToast(
          msg: 'User Is New',
          bgColor: Colors.red.withOpacity(.7),
          txColor: Colors.white.withOpacity(.7));

      return false;
    } else {
      showToast(
          msg: 'this user has data',
          bgColor: Colors.red.withOpacity(.7),
          txColor: Colors.white.withOpacity(.7));

      return true;
    }
  }

  static Future<void> addUser({
    required String? email,
    required String? phoneNumber,
    required String? displayName,
    required String? photoURL,
  }) {
    // Call the user's CollectionReference to add a new user

    return usersCollection
        .doc(email)
        .set({
      'email': email,
      // John Doe
      'phoneNumber': phoneNumber,
      // John Doe
      'displayName': displayName,
      // Stokes and Sons
      'photoURL':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyGdwrHRr5hroz-7f_fWYxMNphZj0N1wh3qA&usqp=CAU',
      'friends': [],
      'chats': []
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
