import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/bloc/workout_bloc.dart';
import 'package:flutter_app1/bloc/workout_event.dart';
import 'package:flutter_app1/bloc/workout_state.dart';
import 'package:flutter_app1/service/repositories/wordRepository.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Worcout1  extends StatelessWidget{
  WordRepository repository=WordRepository();
  @override
  Widget build(BuildContext context) {
    ModalRoute ? route = ModalRoute.of(context); // as Set<int>;
    List<Word> words = [];//FilterModel(true, {});
    words =route!.settings.arguments as List <Word>;
    return BlocProvider<WorkoutBloc>(create: (context)=>WorkoutBloc(words: words, repository: repository),
   child: Scaffold(
     appBar: AppBar(title: Text('worcout1'),),
     body: BlocBuilder<WorkoutBloc, WorkoutState> (builder: (context, state){
       String question='rrr';

        if(state is WorkoutQuestState) {print('questState') ; question= state.word.english;};
       WorkoutBloc workoutBloc = context.read<WorkoutBloc>();
    return Column(
         children:[

           Text(question),
           ElevatedButton(onPressed: (){

             workoutBloc.add(WorkoutNextEvent());

           }, child: Text('next')),

       ElevatedButton(onPressed: (){
       workoutBloc.add(WorkoutPrewEvent());

       }, child: Text('prew')),
     ]

     );
     }
   ))
    );
  }

}