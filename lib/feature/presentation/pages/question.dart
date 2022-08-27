import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_question_entiti.dart';
import 'package:flutter_app1/feature/presentation/bloc/helper_list_bloc/helper_list_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/lang_bloc/lang_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/worcout_bloc/worcout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override void initState(){
    context.read<WorcoutBloc>().add(const WorcoutEventNext());
  }

  @override
  Widget build(BuildContext context) {
        final state=context.watch<WorcoutBloc>().state;

    return ListView(
        children: [
          //
         // Container(height: 100),

          state.when(
              next: (wordEntiti, halperList)  {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text('id=${wordEntiti.id.toString()}   ', style: const TextStyle(fontSize: 15) ),
                        Text('rating=${wordEntiti.rating.toString()}   ', style: const TextStyle(fontSize: 15) ),
                      ],
                    ),
                    Container(height: 100),

                     Text(wordEntiti.question),
                   Container(height: 30),

                   helperList(wordEntiti, halperList),
                   Container(height: 10),
                    SizedBox(
                      width: 250,
                      child: TextField(

                        onSubmitted: (examination){
                          List<WordQuestionEntiti>helper=[];
                          WordQuestionEntiti wordquest=WordQuestionEntiti(id: 0, dataAdd: 0, rating: 0 , question: ' ', answer: ' ', lang: true);
                          context.read<WorcoutBloc>().state.maybeWhen(next: (wordent, help){wordquest=wordent; helper=help;}, prev:  (wordent){wordquest=wordent;},
                              orElse:() {});
                          context.read<WorcoutBloc>()
                              .add(WorcoutEventCheckText(examination: examination, wordQuestionEntiti: wordquest ));
                        },
                        style: TextStyle(fontSize: 22),
                      ),
                    ),


                   // Container(
                   //   height:200,
                   //   child: ListView.builder(
                   //       itemCount:halperList.length,
                   //       itemBuilder:(BuildContext context, int) {return Center(
                   //         child: Container( height: 30,
                   //           child: InkWell(child: Text(halperList[int].answer, style: const TextStyle(fontSize: 25, color: Colors.grey),),
                   //             onTap: (){
                   //               context.read<WorcoutBloc>()
                   //                   .add(WorcoutEventCheck(examination: halperList[int].answer, wordQuestionEntiti: wordEntiti ));
                   //             }),
                   //         ),
                   //       );}),
                   // )
                  ],
                );
               },

              prev: (wordEntiti){
                return Column(
                  children: [
                    Row(
                      children: [
                        Text('id=${wordEntiti.id.toString()}   ', style: const TextStyle(fontSize: 15) ),
                        Text('rating=${wordEntiti.rating.toString()}   ', style: const TextStyle(fontSize: 15) ),
                      ],
                    ),

                    Container(height: 100),
                    Text(wordEntiti.question),
                    Container(height: 200)
                  ],
                );
              },
              check: (answer, helper){
                String handAnsw='';
                if(answer.mistake){handAnsw='no=> ';} else {handAnsw='yes=> ';}
                return
              Column(
                children: [
                  //Text('id=${wordEntiti.id.toString()}   ', style: const TextStyle(fontSize: 15) ),
                  Container(height: 120),

                  Text(handAnsw+answer.answer),
                Container(
                height:200,
                child: ListView.builder(
                itemCount:helper.length,
                itemBuilder:(BuildContext context, element) {
                  Color color =Colors.grey;
                  double fontSizeEl=23;
                  if(helper[element].colorBackgroundUnit=='red'){color=Colors.red; fontSizeEl=27;}
                  if(helper[element].colorBackgroundUnit=='white'){color=Colors.green;fontSizeEl=27;}

                  return Center(
                child: Container( height: 30,
                child: InkWell( child: Text(helper[element].answer, style:  TextStyle(fontSize: fontSizeEl,
                    color: color),),
                onTap: (){  }
                ),
                ),
                );}),
                )
                ],
              );},



              checkText: (answer, examination){
              //  return Text('text');

                String handAnsw='';
                if(answer.mistake){handAnsw='no=> ';} else {handAnsw='yes=> ';}
                return
                  Column(
                    children: [
                      //Text('id=${wordEntiti.id.toString()}   ', style: const TextStyle(fontSize: 15) ),
                      Container(height: 120),

                      Text(handAnsw+answer.answer),
                      Container(
                        height:200

                      ),

                      Text(examination)
                    ],
                  );

              },


              loading: ()=>const Text('loading')
          ),



//           TextField(
//
// onSubmitted: (examination){
//   List<WordQuestionEntiti>helper=[];
//   WordQuestionEntiti wordquest=WordQuestionEntiti(id: 0, dataAdd: 0, rating: 0 , question: ' ', answer: ' ', lang: true);
//   context.read<WorcoutBloc>().state.maybeWhen(next: (wordent, help){wordquest=wordent; helper=help;}, prev:  (wordent){wordquest=wordent;},
//       orElse:() {});
//   context.read<WorcoutBloc>()
//       .add(WorcoutEventCheck(examination: examination, wordQuestionEntiti: wordquest, helper: helper ));
// },
//           ),
          Container(height: 10),

          Column(
            children: [
              SizedBox(
                height: 40,
                width: 300,
                child: Row(
                  children: [
                    ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(const WorcoutEventPrev());}, child: const Text('  prev  ')),
                    Container(width: 12),


                    ElevatedButton(onPressed: (){}, child: const Text("I D'NT KNOW")),
                    Container(width: 12),
                    ElevatedButton(onPressed: (){}, child: const Text('I KNOW')),

                    // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventRus());}, child: Text('rus')),
                    // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventEngl());}, child: Text('engl')),
                    // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventEnglRus());}, child: Text('engl/rus')),
                    // Expanded(child: Text('state:${context.read<LangBloc>().state} '))
                  ],
                ),
              ),
              Container(height: 10),
              SizedBox(
                height: 50,
                width:300,
                  child: ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(const WorcoutEventNext());}, child: const Text('NEXT'))),
            ],
          ),


        ],
      );

      //Container();
  }
  Widget helperList(wordEntiti, halperList){
    final stateHelperList = context.watch<HelperListBloc>().state;
   return stateHelperList.when(
        hiden: (){return Container(
         height:170,
         // width: 300,
          child: ListView.builder(
              itemCount:halperList.length,
              itemBuilder:(BuildContext context, int) {return Center(
                child: Container( height: 30,
                  child: InkWell(child: Text(halperList[int].answerHiden, style: const TextStyle(fontSize: 25, color: Colors.grey),),
                      onTap: (){
                           context.read<HelperListBloc>()
                               .add(HelperListEvent.visibl());

                        // context.read<WorcoutBloc>()
                        //     .add(WorcoutEventCheck(examination: halperList[int].answer, wordQuestionEntiti: wordEntiti ));
                      }),
                ),
              );}),
        );
          },


        visibl: (){return
          Container(
            height:200,
            child: ListView.builder(
                itemCount:halperList.length,
                itemBuilder:(BuildContext context, int) {return Center(
                  child: Container( height: 30,
                    child: InkWell(child: Text(halperList[int].answer, style: const TextStyle(fontSize: 25, color: Colors.grey),),
                      onTap: (){
                        context.read<WorcoutBloc>()
                            .add(WorcoutEventCheck(examination: halperList[int].answer, wordQuestionEntiti: wordEntiti, helper: halperList ));
                      }),
                  ),
                );}),
          );
        });

  }

}
