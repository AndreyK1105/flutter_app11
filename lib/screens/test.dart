

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class MyApp1 extends StatelessWidget{
   int counter=0;

  //final Future <FirebaseApp> _initializition = Firebase.initializeApp();
  //FirebaseApp app ;


// MyApp1({Key key, this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(


        home:   Container(

            child:   Scaffold(

              body: Column(


                children: [
                  Container(width: 0, height: 100,),
                Text("Counter= ${context.watch<CounterModel>().counter}", style: TextStyle(fontSize: 30),),
                  //CountText(),



                  ElevatedButton(onPressed: (){
                    context.read<CounterModel>().addCounter();

                   // var  _counterModel =Provider.of<CounterModel>(context);

                    //_counterModel.addCounter();

                    }, child: Text("counter++ "),),

                  ElevatedButton(onPressed: (){
                    showDialog();

                  }, child: Text("creatUser")),
                  ElevatedButton(onPressed: (){

                  }, child: Text("in")),
                ElevatedButton(onPressed: (){

        }, child: Text("Out")),




                ],

              ),

            )

        ),
      );




  }
  void showDialog(){


}
  Future<void> _base() async {
    //final FirebaseApp app1 = await Firebase.initializeApp();

    final FirebaseDatabase database = FirebaseDatabase();
  final  ref = FirebaseDatabase.instance.reference();
  final _messegRef = database.reference().child("messages");
 //await _messegRef.child("mes").push();
//  database.reference().push().child("mess");
  await ref.child("messades").set("dsajhga");

  }

}
class CountText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Text("Counter= ${context.watch<CounterModel>().counter}", style: TextStyle(fontSize: 30),);
   // Consumer<CounterModel>(builder: (context, counter, child) {
     // return Text("Counter= ${counter._counter}", style: TextStyle(fontSize: 30),);
    //});

  }
  

}
class CounterModel with ChangeNotifier {

  int _counter = 1;

  int get counter => _counter;

  void addCounter() {
    _counter++;
    notifyListeners();
  }
}