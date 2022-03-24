import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/bloc/workout_state.dart';
import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/presentation/bloc/cubit/cubit_helper.dart';
import 'package:flutter_app1/feature/presentation/bloc/hel;per_list_bloc/helper_list_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/heper_turn_cubit/helper_list_turn_cubit.dart';
import 'package:flutter_app1/feature/presentation/bloc/lang_bloc/lang_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/worcout_bloc/worcout_bloc.dart';
import 'package:flutter_app1/feature/presentation/pages/question.dart';
import 'package:flutter_app1/feature/presentation/pages/worcout_body.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorcoutPage extends StatelessWidget {
  late RepoWord repoWord;
  List <WordEntiti> words = [];

  WorcoutPage({Key? key}) : super(key: key);

  @override
  void InitState() {

  }

  @override
  Widget build(BuildContext context) {
    ModalRoute ? route = ModalRoute.of(context);
    words = route!.settings.arguments as List <WordEntiti>;
    print(words.length);
    repoWord = RepoWord(wordsEntiti: words);
    //LangBloc langBloc;
    return MultiBlocProvider(
      providers: [
         BlocProvider <LangBloc>(

           create: (context) => LangBloc(),),
        BlocProvider<CubitHelper>(create: (context)=>CubitHelper()),

        BlocProvider<HelperListTurnCubit>(
            create:(context) =>HelperListTurnCubit()),

        BlocProvider<HelperListBloc>(
            create: (context)=> HelperListBloc()),

        BlocProvider<WorcoutBloc>(
            create: (context)=> WorcoutBloc( repoWord: repoWord, langBloc:  BlocProvider.of<LangBloc>(context),
              helperListTurnCubit: BlocProvider.of<HelperListTurnCubit>(context),
              helperListBloc: BlocProvider.of<HelperListBloc>(context))

                ),


      ],
      child: WorcoutBody()
    );
    }


     Widget scaffold(BuildContext context) {

    return  Scaffold(


        appBar: AppBar(
          actions: <Widget>[
            // IconButton(
            //     onPressed: (){
            //       context.read<HelperListTurnCubit>().helperListTurnSwith();
            //                       },
            //     icon: Icon(Icons.help)
            // ),

          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {}
          ),
          ],
        ),


        body: Column(
          children: [ElevatedButton(onPressed: () {context.read <LangBloc>().add(LangEventRus());}, child: Text('lang')),
            Question(),
          ],
        ),
      );
  }

}

void _selectLang(BuildContext context){

  context.read() <LangBloc>().add(LangEventRus());
}
// Future <Widget> showdialog (BuildContext context) {
//
//   return showDialog(
//     context: context,
//     builder: (  context){
//       return AlertDialog(
//         title: Text("выбор языка"),
//         actions: <Widget>[
//           TextButton(
//               child: Text('Cancel'),
//               onPressed: () => Navigator.of(context).pop()
//           ),
//           // TextButton(
//           //     child: Text('Save'),
//           //     onPressed: () => { }
//           // )
//         ],
//         content:
//         _choceList(context),
//       );
//     },);
// }

Widget _choceList (BuildContext context){
  return
   Column(
    children: [

     ChoiceChip(label: Text("Русский"), selected: false,
    onSelected: (value) {
       BlocProvider.of<LangBloc>(context).add(LangEventRus());
      //context.read<LangBloc>().add(LangEventRus());
      Navigator.of(context).pop();
      print('_choceEngl');
    }
    ),
  ]
  );

}