import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/word.dart';
import 'format.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('word').snapshots();



Widget tile (Word word){
  return

    Row(children: [
    Text('english ${word.english} --- '),
    Text('russia ${word.russia} '),
    Text('  ${word.transcr} '),
  ],);
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(


    body: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            Word word = Word.fromMapClaud(data);
            return format(word);

          })
              .toList()
              .cast(),
        );
      },
    )

    );
  }
}