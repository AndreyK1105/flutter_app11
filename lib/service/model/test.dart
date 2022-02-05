import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/service/model/userFr.dart';

void main(){
  runApp(App());

}

class App  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String text;
    text= UserFr.fromString('214 arm -рука .. ').russia!+UserFr.fromString('214 arm -рука .. ').english!.toString() ;
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text(text)),
      ),
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.deepOrange,
                fontSize: 23,
                fontWeight: FontWeight.bold)),
        primaryColor: Colors.greenAccent,
        splashColor: Colors.amber,

      ),
      themeMode: ThemeMode.system,
      title: "hkc",

    );
    throw UnimplementedError();
  }
}
