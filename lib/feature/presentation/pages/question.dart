import 'package:flutter/material.dart';
import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_question_entiti.dart';
import 'package:flutter_app1/feature/presentation/bloc/lang_bloc/lang_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/worcout_bloc/worcout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    final state=context.watch<WorcoutBloc>().state;
    return  Column(
        children: [Container(height: 100),

          state.when(
              next: (wordEntiti, halperList)  {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text('id=${wordEntiti.id.toString()}  '),
                         Expanded(child: Text(wordEntiti.question)),
                                                  ]

                    ),
                   Column(
                     children: [
                    //   Text(wordEntiti.answer),
                       Text(halperList[0].answer, ),
                       Text(halperList[1].answer),
                       Text(halperList[2].answer),
                       Text(halperList[3].answer),
                       Text(halperList[4].answer),
                       Text(halperList[5].answer),
                     ],
                   )
                  ],
                );
               },

              prev: (wordEntiti){
                return Row(
                    children: [
                      Text('id=${wordEntiti.id.toString()}  '),
                      Text(wordEntiti.question)
                    ]);
              },
              check: (answer)=> Text(answer.answer),

              loading: ()=>Text('loading')
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(WorcoutEventPrev());}, child: Text('prev')),

                ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(WorcoutEventNext());}, child: Text('next')),

                // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventRus());}, child: Text('rus')),
                // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventEngl());}, child: Text('engl')),
                // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventEnglRus());}, child: Text('engl/rus')),
               // Expanded(child: Text('state:${context.read<LangBloc>().state} '))
              ],
            ),

          TextField(
onSubmitted: (examination){
  WordQuestionEntiti wordquest=WordQuestionEntiti(id: 0, dataAdd: 0, rating: 0 , question: ' ', answer: ' ', lang: true);
  context.read<WorcoutBloc>().state.maybeWhen(next: (wordent, help){wordquest=wordent;}, prev:  (wordent){wordquest=wordent;},
      orElse:() {});
  context.read<WorcoutBloc>()
      .add(WorcoutEventCheck(examination: examination, wordQuestionEntiti: wordquest ));
},
          )
        ],
      );

      //Container();
  }
}
