import 'package:firebase_auth/firebase_auth.dart';

class User1 {
  String _id='0';

  User1.fromFirebase(User user){
    if (user.uid==null) {
      _id = " ";
    } else {
      _id = user.uid;
    }
  }
}