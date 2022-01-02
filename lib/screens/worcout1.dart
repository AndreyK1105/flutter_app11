import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/bloc/workout_bloc.dart';
import 'package:flutter_app1/bloc/workout_event.dart';
import 'package:flutter_app1/bloc/workout_state.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Worcout1  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('worcout1'),),
     body: BlocBuilder<WorkoutBloc, WorkoutState> (builder: (context, state){
       String question= (state as Word).english;
       WorkoutBloc workoutBloc = context.read<WorkoutBloc>();
    return Column(
         children:[

           Text(question),
           ElevatedButton(onPressed: (){
             workoutBloc.add(WorkoutNextEvent());

           }, child: Text('next'))
     ]

     );
     }
   ));
  }

}