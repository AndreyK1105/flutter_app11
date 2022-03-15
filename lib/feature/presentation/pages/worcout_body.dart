
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/feature/presentation/bloc/lang_bloc/lang_bloc.dart';
import 'package:flutter_app1/feature/presentation/pages/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorcoutBody extends StatelessWidget {
  const WorcoutBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LangBloc langBloc = context.read<LangBloc>();

    return Scaffold(

      appBar: AppBar(
          actions: <Widget>[


            Badge(
              badgeContent: Text(textLangSelection(context),
                style: const TextStyle(color: Colors.white,
                    fontSize: 10),
              ),
              shape: BadgeShape.square,
              borderRadius: BorderRadius.circular(8),
              position: BadgePosition.topEnd(top: -3, end: -8),
              child: IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: () {
                    print(langBloc.state);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("выбор языка"),
                          actions: <Widget>[
                            TextButton(
                                child: const Text('Cancel'),
                                onPressed: () => Navigator.of(context).pop()
                            ),
                            // TextButton(
                            //     child: Text('Save'),
                            //     onPressed: () => { }
                            // )
                          ],
                          content:

                          _choceList(context, langBloc),
                        );
                      },);
                  }),
            ),
            Container(width: 10,)
          ]
      ),


      body: Column(
        children: const [ //WorcoutBody(),
          Question(),
        ],
      ),
    );

    // ElevatedButton(onPressed: () {context.read <LangBloc>().add(LangEventRus());}, child: Text('lang'));

  }
}

  String textLangSelection (BuildContext context){
    final state=context.watch<LangBloc>().state;
    String select='eng';
   return state.when(
        engl:() {select = 'eng'; return select;},
        rus: (){select= 'rus'; return select;},
        englrus:(){select='en/ru'; return select;}
   );
  }


Widget _choceList (BuildContext context, LangBloc langBloc) {
  return
    Column(
        children: [

          ChoiceChip(label: const Text("Английский"), selected: false,
              onSelected: (value) {
               print(langBloc.state);
              langBloc.add(const LangEventEngl());
                //context.read<LangBloc>().add(LangEventRus());
                Navigator.of(context).pop();

              }
          ),

          ChoiceChip(label: const Text("Русский"), selected: false,
              onSelected: (value) {
                print(langBloc.state);
                langBloc.add(const LangEventRus());
                //context.read<LangBloc>().add(LangEventRus());
                Navigator.of(context).pop();

              }
          ),

          ChoiceChip(label: const Text("Англ/Русский"), selected: false,
              onSelected: (value) {
                print(langBloc.state);
                langBloc.add(const LangEventEnglRus());
                //context.read<LangBloc>().add(LangEventRus());
                Navigator.of(context).pop();

              }
          ),
        ]
    );
}