
import 'package:flutter/material.dart';
import 'package:flutter_app1/feature/presentation/bloc/lang_bloc/lang_bloc.dart';
import 'package:flutter_app1/feature/presentation/pages/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorcoutBody extends StatelessWidget{
  const WorcoutBody({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    LangBloc langBloc = context.read<LangBloc>();
    return Scaffold(

      appBar: AppBar(
        actions: <Widget>[

          IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    Widget dialog= AlertDialog(
                      title: Text("выбор языка"),
                      actions: <Widget>[
                        TextButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop()
                        ),
                        // TextButton(
                        //     child: Text('Save'),
                        //     onPressed: () => { }
                        // )
                      ],
                      content:

                      Column(
                        children: [
                          ElevatedButton(onPressed: (){context.read<LangBloc>().add(LangEventRus());}, child: Text('rus')),
                          _choceList(context),
                        ],
                      ),
                    );

                    return BlocProvider.value(
                      value: langBloc,
                      child: dialog


                    );
                  },);
              })
  ]
                ),



      body: Column(
        children: [//WorcoutBody(),
         ElevatedButton(onPressed: () {context.read<LangBloc>().add(LangEventRus());}, child: Text('lang')),
          Question(),
        ],
      ),
    );

     // ElevatedButton(onPressed: () {context.read <LangBloc>().add(LangEventRus());}, child: Text('lang'));

  }
}
void _selectLang(BuildContext context){

  context.read <LangBloc>().add(LangEventRus());
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

Widget _choceList (BuildContext context) {
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