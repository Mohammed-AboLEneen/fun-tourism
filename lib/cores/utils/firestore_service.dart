import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_adventure/constants.dart';

class FireStoreServices {
  static final fireStore = FirebaseFirestore.instance;
  static final _homeScreenCollection =
      FirebaseFirestore.instance.collection('appData');

  static Future<DocumentSnapshot> getUserData({required String uId}) async {
    return await fireStore.collection('users').doc(uId).get();
  }

  static Future<bool> checkIfDocumentExists(String uId) async {
    final DocumentReference documentRef =
        fireStore.collection('users').doc(uId);

    final DocumentSnapshot documentSnapshot = await documentRef.get();

    return documentSnapshot.exists;
  }

  static Future<void> addUser({
    required String? email,
    required String? uId,
    required String? phoneNumber,
    required String? displayName,
    required String? photoURL,
  }) {
    // Call the user's CollectionReference to add a new user

    return fireStore
        .collection('users')
        .doc(uId)
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

  static Future<DocumentSnapshot> getHomeScreenData(String doc) async {
    return await _homeScreenCollection.doc(doc).get();
  }

  static Future<int> countUserNotifications() async {
    AggregateQuerySnapshot query = await fireStore
        .collection('users')
        .doc(uId)
        .collection('notifications')
        .count()
        .get();
    return query.count;
  }
}
