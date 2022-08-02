import 'package:firebase_auth/firebase_auth.dart';

String getUserID() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;
  return user!.uid;
}
