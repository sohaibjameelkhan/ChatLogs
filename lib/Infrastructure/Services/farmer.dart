import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import '../Models/user_model.dart';

class FarmerServices {
  ///Get Specific User Details
  Stream<UserModel> getUserDetails(String docID) {
    return FirebaseFirestore.instance
        .collection('userCollection')
        .doc(docID)
        .snapshots()
        .map((event) =>
            UserModel.fromJson(event.data() as Map<String, dynamic>));
  }
}
