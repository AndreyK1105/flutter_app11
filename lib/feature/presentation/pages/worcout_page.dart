import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/bloc/workout_state.dart';
import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/presentation/bloc/worcout_bloc/worcout_bloc.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorcoutPage extends StatelessWidget{
late RepoWord repoWord;
List <WordEntiti> words=[];
  @override
  void InitState(){

  }
  @override
  Widget build(BuildContext context) {
    ModalRoute ? route = ModalRoute.of(context);
    words=route!.settings.arguments as List <WordEntiti>;
    repoWord=RepoWord(wordsEntiti: words);
   return Scaffold(
     body: BlocProvider(
       create: (context)=>WorcoutBloc(repoWord: repoWord),
       child: Center(
         child: Text('text'),
       ),
     ),
   );
  }

}