import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  // Create the controller that will broadcast the user data
  final StreamController<UserData> _userDataController =
      StreamController<UserData>.broadcast();

  Stream listenToUserDataRealTime(String uid, email) {
    // Register the handler for when the posts data changes
    _usersCollectionReference
        .document(uid)
        .snapshots()
        .listen((userDataSnapshot) {
      if (userDataSnapshot.exists) {
        var userData =
            UserData.fromMap(map: userDataSnapshot.data, email: email);

        // Add the user data onto the controller
        _userDataController.add(userData);
      }
    });

    // Return the stream underlying our _userDataController.
    return _userDataController.stream;
  }
}
