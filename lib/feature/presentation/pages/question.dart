import 'package:flutter/material.dart';
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
        children: [Container(height: 300),
          state.when(
              next: (wordEntiti)  {
                return Row(
                  children: [
                    Text('id=${wordEntiti.id.toString()}  '),
                     Text(wordEntiti.english)
                  ]);
               },

              prev: (wordEntiti){
                return Row(
                    children: [
                      Text('id=${wordEntiti.id.toString()}  '),
                      Text(wordEntiti.english)
                    ]);
              },
              check: (answer)=> Text(answer.answer),
              loading: ()=>Text('loading')
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(WorcoutEventPrev());}, child: Text('prev')),

              ElevatedButton(onPressed: (){context.read<WorcoutBloc>().add(WorcoutEventNext());}, child: Text('next')),
            ],
          ),
          TextField(
onSubmitted: (answer){
  context.read<WorcoutBloc>().add(WorcoutEventCheck(ansver: answer));
},
          )
        ],
      );

      //Container();
  }
}