//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/feature/presentation/pages/worcout_page.dart';
import 'package:flutter_app1/screens/dataTable.dart';
import 'package:flutter_app1/screens/home.dart';
//import 'package:flutter_app1/screens/auth.dart';
import 'package:flutter_app1/screens/landing.dart';
import 'package:flutter_app1/screens/listDb.dart';
import 'package:flutter_app1/screens/loadFile.dart';
import 'package:flutter_app1/screens/test.dart';
import 'package:flutter_app1/screens/test1.dart';
import 'package:flutter_app1/screens/test3.dart';
import 'package:flutter_app1/screens/worcout1.dart';
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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  runApp(
    //MyApp1());}

          ChangeNotifierProvider<SliderModel>(
             create: (context) => SliderModel(),

            child: MyApp2()


 )
//}
  );
}
  class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
      routes: {
        '/': (context) => ListDb(),

      },
      onGenerateRoute:(RouteSettings settings){
      final String routName=settings.name??'';
      switch (routName){
        case '/workout':
          return MaterialPageRoute(builder: (BuildContext context)=>Workout(),
        settings: settings,
          );
        case  '/dataTable':
          return MaterialPageRoute<FilterModel>(builder: (BuildContext context) => MyDataTable(),
        settings: settings,);
        case '/worcout1':
          return MaterialPageRoute(builder: (BuildContext context)=>Worcout1(),
       );
        case '/worcout_page':
          return MaterialPageRoute(builder: (BuildContext context)=>WorcoutPage(),
            settings: settings,
          );

        case '/auth_fireBase':
          return MaterialPageRoute(builder: (BuildContext context)=>HomePage(),
            settings: settings,
          );
      }
      },
      theme: ThemeData(
      textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.deepOrange,
      fontSize: 23,
      fontWeight: FontWeight.bold)),
    primaryColor: Colors.greenAccent,
    splashColor: Colors.amber,

    ),
    themeMode: ThemeMode.system,
    title: "hkc",
    //home: ListDb()
  );
  }
  }


class MyApp2 extends StatelessWidget {

  MyApp2({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
       future: _initialization,
    builder: (context, snapshot){
         if(snapshot.hasError){
           print("error");
           return const Text ('error1');

         }
         if(snapshot.connectionState==ConnectionState.done){
           return StreamProvider<User1?>.value(
               value: AuthService().curentUser,


             //initialData: User1 user1=User1(),
             initialData: null,
             child: MaterialApp(
                 theme: ThemeData(
                   textTheme: const TextTheme(
                       bodyText2: TextStyle(color: Colors.deepOrange,
                           fontSize: 23,
                           fontWeight: FontWeight.bold)),
                   primaryColor: Colors.greenAccent,
                   splashColor: Colors.amber,

                 ),
                 themeMode: ThemeMode.system,

               initialRoute: '/',
               routes: {
                 '/': (context) => ListDb(),

               },
               onGenerateRoute:(RouteSettings settings){
                 final String routName=settings.name??'';
                 switch (routName){
                   case '/workout':
                     return MaterialPageRoute(builder: (BuildContext context)=>Workout(),
                       settings: settings,
                     );
                   case  '/dataTable':
                     return MaterialPageRoute<FilterModel>(builder: (BuildContext context) => MyDataTable(),
                       settings: settings,);
                   case '/worcout1':
                     return MaterialPageRoute(builder: (BuildContext context)=>Worcout1(),
                     );
                   case '/worcout_page':
                     return MaterialPageRoute(builder: (BuildContext context)=>WorcoutPage(),
                       settings: settings,
                     );

                   case '/auth_fireBase':
                     return MaterialPageRoute(builder: (BuildContext context)=>HomePage(),
                       settings: settings,
                     );
                   case '/test3':
                     return MaterialPageRoute(builder: (BuildContext context)=>UserInformation(),
                       settings: settings,
                     );
                   case '/load':
                     return MaterialPageRoute(builder: (BuildContext context)=>LoadFile(),
                     );
                 }
               },

                 // title: "hkc",
                 // home: ListDb()

             ),
           );
         }

         return
         const Text("load      LOAD", textDirection: TextDirection.ltr, style: TextStyle(fontSize: 35),);

    }
    );
  }

}






