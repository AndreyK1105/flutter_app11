import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/service/word.dart';

class ServDatabase{
  //final FirebaseDatabase _firebaseDatabase = FirebaseDatabase();
  final ref= FirebaseDatabase.instance.reference();
  final CollectionReference collectionReference =FirebaseFirestore.instance.collection("word");
  final String refDoc="ZQMn1TPYN8xAbiVy53IK";
  Future baseCloudPut(String word, String russia, String transcr) async{
    final Map <String, String> data= {"inglish": word, "russia": russia, "transcr":transcr};
    DocumentReference documentReference = collectionReference.doc();
    return documentReference.set(data);
  }


  /*Stream <List<Word>> getWords () {
    var query = collectionReference.where("inglish", isEqualTo: "ert");
    return query.snapshots().map((QuerySnapshot data) => data.docs.map((DocumentSnapshot doc)=>Word.fromJson(doc.data())).toList());
  }

   */
    Future<void> basePut(String word, String russia, String transcr) async {
      await ref.child("Dictionary").child(word).child("russia").set(russia);
      await ref.child("Dictionary").child(word).child("transcr").set(transcr);
    }



}