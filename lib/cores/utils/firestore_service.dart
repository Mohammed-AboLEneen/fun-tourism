import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static final _usersCollection =
      FirebaseFirestore.instance.collection('users');
  static final _homeScreenCollection =
      FirebaseFirestore.instance.collection('appData');

  static Future<DocumentSnapshot> getUserData({required String uId}) async {
    return await _usersCollection.doc(uId).get();
  }

  static Future<bool> checkIfDocumentExists(String uId) async {
    final DocumentReference documentRef = _usersCollection.doc(uId);

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

    return _usersCollection
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
}
