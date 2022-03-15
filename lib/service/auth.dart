import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app1/screens/home.dart';
import 'package:flutter_app1/service/user.dart';

class AuthService{

  final FirebaseAuth  _fAuth = FirebaseAuth.instance;
  Future <User1?> signInWithEmailAndPassword(String email, String password) async {

    try {

      UserCredential? result =await _fAuth.signInWithEmailAndPassword(email: email, password: password);
     User user =result.user!;
     return User1.fromFirebase(user);
    }
    catch(e){}
  }
  Future <User1?> registerWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential? result =await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user =result.user!;
      return User1.fromFirebase(user);
    }
    catch(e){}
  }

  Future logOut() async{
     await _fAuth.signOut();
  }

  Stream<User1> get curentUser{
    return _fAuth.authStateChanges().map((User? user)=>User1.fromFirebase(user!));
  }

}