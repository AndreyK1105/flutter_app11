//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app1/screens/auth.dart';
import 'package:flutter_app1/screens/landing.dart';
import 'package:flutter_app1/screens/listDb.dart';
import 'package:flutter_app1/screens/test.dart';
import 'package:flutter_app1/screens/test1.dart';
import 'package:flutter_app1/screens/workout.dart';
//import 'package:flutter_app1/screens/test.dart';
import 'package:flutter_app1/service/auth.dart';
import 'package:flutter_app1/service/db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'service/user.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Db.init();

  runApp(
    //MyApp1());}

          ChangeNotifierProvider<SliderModel>(
             create: (context) => SliderModel(),

            child:MyApp()


 )
//}
  );
}
  class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
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
    home: ListDb()
  );
  }
  }


class MyApp2 extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
       future: _initialization,
    builder: (context, snapshot){
         if(snapshot.hasError){
           print("error");
           return Text ('error1');

         }
         if(snapshot.connectionState==ConnectionState.done){
           return StreamProvider<User1?>.value(
               value: AuthService().curentUser,


             //initialData: User1 user1=User1(),
             initialData: null,
             child: MaterialApp(
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
                 home: ListDb()

             ),
           );
         }

         return
         Container(child: Text("load      LOAD", textDirection: TextDirection.ltr, style: TextStyle(fontSize: 35),));

    }
    );
  }

}






