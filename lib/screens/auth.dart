import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/listDb.dart';
import 'package:flutter_app1/service/auth.dart';
import 'package:flutter_app1/service/servDatabase.dart';
import 'package:flutter_app1/service/word.dart';

class AuthPage extends StatefulWidget{
  @override

  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>{
final TextEditingController _wordController=TextEditingController();
final TextEditingController _russiaController=TextEditingController();
final TextEditingController _transcrController=TextEditingController();
final ServDatabase servDatabase = ServDatabase();
  @override
  Widget build(BuildContext context) {
    Widget _list(){

        CollectionReference user =FirebaseFirestore.instance.collection("word");
        return StreamBuilder<QuerySnapshot>(
          stream: user.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text("error");
            }
            if(snapshot.connectionState==ConnectionState.done){
              return Text("Loading");
            }
            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document){
                return ListTile (
                  title: Text(document.get("inglish")),
                  subtitle: Text(document.get("russia")),
                );
            }).toList(),

            );
          },

);

         };
    Widget _logo() {
      return Padding(padding: EdgeInsets.only(top: 15),
      child: Container(
        child:Align(
          child: Column(
            children: [
              Text("Dictionary",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller:_wordController, style: TextStyle(fontSize: 30),
                decoration: InputDecoration(hintText: "word inglish"),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller:_russiaController, style: TextStyle(fontSize: 30),
                  decoration: InputDecoration(hintText: "перевод"),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller:_transcrController, style: TextStyle(fontSize: 30),
                  decoration: InputDecoration(hintText: "транскрипция"),),
              ),

              ElevatedButton(onPressed: (){

                servDatabase.baseCloudPut(_wordController.text, _russiaController.text, _transcrController.text);
                _wordController.clear();
                _russiaController.clear();
                _transcrController.clear();

              }, child: Text("go")),
              ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListDb()),
                );



              }, child: Text("listDb")),


            ],
          ),
        ),
        ),);
    };

    return Scaffold(
      appBar: AppBar(title: Text("app bar"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.outbox), onPressed: (){AuthService().logOut();})
      ],),
      backgroundColor: Theme.of(context).primaryColor,
      //appBar: AppBar(title: Text("Title", style: TextStyle(fontSize: 25),) ),
      body: Column(
        children: <Widget>[
          _logo(),

         // _list(),




        //_form,
        ],
      ),
    );
  }

}
