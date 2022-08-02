import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user_model.dart';

class AuthServices {
  ///Register User
  Future registerUser({required String email, required String password}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  ///Login User
  Future<User> loginUser(
      {required String email, required String password}) async {
    UserCredential _userCred = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return _userCred.user!;
  }

  ///Reset Password
  Future resetPassword({required String email}) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //
  // Future resetConfirmPassword({required String email}) async {
  //   return await FirebaseAuth.instance.then((value) => null);
  // }
  Stream<UserModel> checkIfUserAllowed(String docID) {
    return FirebaseFirestore.instance
        .collection('userCollection')
        .doc(docID)
        .snapshots()
        .map((event) {
      return UserModel.fromJson(event.data()!);
    });
  }

  ///SignOut
  Future signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
