import 'package:flutter/material.dart';
import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_question_entiti.dart';
import 'package:flutter_app1/feature/presentation/bloc/hel;per_list_bloc/helper_list_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/lang_bloc/lang_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/worcout_bloc/worcout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return  Column(
        children: [Container(height: 100),

          state.when(
              next: (wordEntiti, halperList)  {
                return Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('id=${wordEntiti.id.toString()}   ', style: const TextStyle(fontSize: 15) ),
                            Text('rating=${wordEntiti.rating.toString()}   ', style: const TextStyle(fontSize: 15) ),

                          ],
                        ),
                         Expanded(child: Text(wordEntiti.question)),
                                                  ]

                    ),
                   Container(height: 30),

                   helperList(wordEntiti, halperList),

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
                          Text('id=${wordEntiti.id.toString()}  '),
                          Text(wordEntiti.question),
                          Container(height: 200)
                        ]),
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

                  Text(handAnsw+answer.answer),
                Container(
                height:200,
                child: ListView.builder(
                itemCount:helper.length,
                itemBuilder:(BuildContext context, int) {
                  Color color =Colors.grey;
                  if(helper[int].colorBackgroundUnit=='red'){color=Colors.red;}
                  if(helper[int].colorBackgroundUnit=='white'){color=Colors.green;}

                  return Center(
                child: Container( height: 30,
                child: InkWell( child: Text(helper[int].answer, style:  TextStyle(fontSize: 25,
                    color: color),),
                onTap: (){  }
                ),
                ),
                );}),
                )
                ],
              );},

              loading: ()=>const Text('loading')
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(const WorcoutEventPrev());}, child: const Text('prev')),

                ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(const WorcoutEventNext());}, child: const Text('next')),

                // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventRus());}, child: Text('rus')),
                // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventEngl());}, child: Text('engl')),
                // ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventEnglRus());}, child: Text('engl/rus')),
               // Expanded(child: Text('state:${context.read<LangBloc>().state} '))
              ],
            ),

          TextField(
onSubmitted: (examination){
  List<WordQuestionEntiti>helper=[];
  WordQuestionEntiti wordquest=WordQuestionEntiti(id: 0, dataAdd: 0, rating: 0 , question: ' ', answer: ' ', lang: true);
  context.read<WorcoutBloc>().state.maybeWhen(next: (wordent, help){wordquest=wordent; helper=help;}, prev:  (wordent){wordquest=wordent;},
      orElse:() {});
  context.read<WorcoutBloc>()
      .add(WorcoutEventCheck(examination: examination, wordQuestionEntiti: wordquest, helper: helper ));
},
          )
        ],
      );

      //Container();
  }
  Widget helperList(wordEntiti, halperList){
    final stateHelperList = context.watch<HelperListBloc>().state;
   return stateHelperList.when(
        hiden: (){return Container(
          height:200,
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
