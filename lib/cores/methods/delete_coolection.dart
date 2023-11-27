import 'package:cloud_firestore/cloud_firestore.dart';

void deleteFireStoreCollection(CollectionReference collection) async {
  final snapshot = await collection.get();
  for (final doc in snapshot.docs) {
    await doc.reference.delete();
  }
}
