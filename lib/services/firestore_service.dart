import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firecek_stacked_architecture/models/product.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _productCollectionReference =
      Firestore.instance.collection('products');

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

  //user data future
  Future userDataFuture(String uid, email) async {
    //get
    var snapshot = await _usersCollectionReference.document(uid).get();
    var userData = UserData.fromMap(map: snapshot.data, email: email);
    return userData;
  }

  //delete array index in users->uid->myProduct
  Future deleteProductFromUser(String uid, productKey) async {
    await _usersCollectionReference.document(uid).updateData({
      "myProduct": FieldValue.arrayRemove([productKey])
    });
    print(
        '(TRACE) FirestoreService:deleteProductFromUser. key: $uid productKey: $productKey');
  }

  //listen to stream product list
  // Create the controller that will broadcast the product list
  final StreamController<List<Product>> _productController =
      StreamController<List<Product>>.broadcast();

  Stream listenToProductListRealTime() {
    // Register the handler for when the posts data changes
    _productCollectionReference.snapshots().listen((productsSnapshot) {
      if (productsSnapshot.documents.isNotEmpty) {
        var products = productsSnapshot.documents
            .map((snapshot) => Product.fromMap(map: snapshot.data))
            .where((mappedItem) => mappedItem.idProduct != null)
            .toList();

        // Add the posts onto the controller
        _productController.add(products);
      }
    });

    // Return the stream underlying our _postsController.
    return _productController.stream;
  }
}
