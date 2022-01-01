
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/service/db.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Workout extends StatefulWidget {


  @override
  _Workout  createState() =>_Workout();
}
  class _Workout extends State <Workout>{

    bool _selected=true;
    bool _choceEngl=true;
    bool _choceRus=false;
    bool _choceEnglRus=false;
  String _langWorkout="eng";
  bool _englishWorkout=true;
  bool _rusianWorkout=false;
  late File _image;
  late File _image2;
  final picker= ImagePicker();
  late String path;
    late String path2;
    late List <Word> _tasks=[];
    late int leght;
     List <int> ?indexRnd;
     List <int>? rndIndex;
    int indexWork=0;
    TextEditingController answerController = TextEditingController();

    late String question;
    late String answer;

    int ratingMax=10;

    RefreshModel _refreshModel= RefreshModel();

 //
    @override
    initState() {



     // refreshDb();
      super.initState();
    }
   void refreshDb(){


      /*
      List<Map<String, dynamic>> _results = await Db.query(Word.table);
      _tasks = _results.map((item) => Word.fromMap(item)).toList();
      leght= _tasks.length;
      setState(() {
        refreshIndexRnd();


      });
    */


    }

    void refreshIndexRnd(int leght) {
      indexRnd = List.filled(leght, 0);
      rndIndex = List.filled(leght, -1);
      Random random = Random();
      int index;
      for (int i = 0; i < leght; i++) {
        do {
          index = random.nextInt(leght);
        }
        while (rndIndex![index] != -1);
        indexRnd![i] = index;
        rndIndex![index] = i;

        print('i==$i  Index==$index');
      }
    }

    void _saveupdate(Word item) async {


      await Db.update(Word.table, item);
      print("rating:${item.rating}");
      //setState(() => { });
      //refresh();
    }



    /*Future<String> get _localPath async {
      final directory = await getApplicationDocumentsDirectory();
      path2=directory.path+'/image.jpg';
      print(directory.path);

      return path2;
    }

     */

 /* Future getImage() async{
final picker=ImagePicker();
    final directory = await getApplicationDocumentsDirectory();
    final path =directory.path;
    print(directory.path);

    final  pickedFile= await picker.getImage(source: ImageSource.camera);

     File  newImage= await File(pickedFile!.path).copy("$path/image.jpg");
     setState(() {
       if (pickedFile!=null){
         _image=File(pickedFile.path);
         _image2=newImage;
         String _name=extension(pickedFile.path);
         print('name ********: $_name');
       }
       else {
         print ('no file');
       }
     });

  }

  */

  void _saveLang(){
    //Navigator.of(context).pop() ;

  }

  void nextWord() async{
    answerController.text="";
    await {_saveupdate(_tasks[rndIndex![indexWork]])};

    setState(() {
      if (indexWork<leght-1){
        indexWork++;
      }else{indexWork=0;}
    });
  }

  void backWord() {
    answerController.text="";
    setState(() {
      if(indexWork==0){indexWork=leght-1;}
      else{indexWork--;}
    });

  }

  void noKhowAnswer() {
    if( _tasks[rndIndex![indexWork]].rating>1){_tasks[rndIndex![indexWork]].rating=_tasks[rndIndex![indexWork]].rating-2;}
    if( _tasks[rndIndex![indexWork]].rating==1){_tasks[rndIndex![indexWork]].rating--;}


      answerController.text = answer;

  }

    void checkAnswer(BuildContext context){
    if(answer==answerController.text){
      Fluttertoast.showToast(msg: 'ok!',
        toastLength:Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.greenAccent, );
      if(_tasks[rndIndex![indexWork]].rating<10){ _tasks[rndIndex![indexWork]].rating++;}


     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ok")));
      nextWord();}else{
      if(_tasks[rndIndex![indexWork]].rating>0){ _tasks[rndIndex![indexWork]].rating--;}
      Fluttertoast.showToast(msg: 'no!',
        toastLength:Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red, );
    }
    }

  @override
  Widget build(BuildContext context) {
if(_tasks.length==0) {
  ModalRoute ? route = ModalRoute.of(context); // as Set<int>;
  _tasks = //FilterModel(true, {});
  route!.settings.arguments as List <Word>;
  leght=_tasks.length;
  refreshIndexRnd(leght);
}
    Widget wordQuestion () {
      if (_tasks == null) {
        return Text('null');
      }
      else {


        if (_langWorkout=="eng"){
          question=_tasks[rndIndex![indexWork]].english;
          answer=_tasks[rndIndex![indexWork]].russia;
          return Text(question);
        }else if(_langWorkout=="rus"){
          question=_tasks[rndIndex![indexWork]].russia;
          answer=_tasks[rndIndex![indexWork]].english;
          Text(question);
        }else if(_langWorkout=="eng/rus") {
          Random rnd = Random();
          if (rnd.nextInt(2) == 0) {
            question=_tasks[rndIndex![indexWork]].russia;
            answer=_tasks[rndIndex![indexWork]].english;
            return Text(question);
          }
          else {
            question=_tasks[rndIndex![indexWork]].english;
            answer=_tasks[rndIndex![indexWork]].russia;
            return Text(question);
          }
        }
        return Text(_tasks[rndIndex![indexWork]].russia);

      }
    }

    Widget _choiceEngl(){return
      ChoiceChip(label: Text("English"),
        selected: _choceEngl,
        onSelected: (value){
          setState(() {
            _choceEngl=!_choceEngl;
            if(_choceRus)_choceRus=!_choceRus;
            if(_choceEnglRus)_choceEnglRus=!_choceEnglRus;
            _langWorkout="eng";
            Navigator.of(context).pop();

            print('_choceEngl$_choceEngl');
          });
        },
      );
    }


    Widget _choiceRus(){return
      ChoiceChip(label: Text("Русский"), selected: _choceRus,
        onSelected: (value){
          setState(() {
            if(_choceEngl)_choceEngl=!_choceEngl;
            _choceRus=!_choceRus;
            if(_choceEnglRus) _choceEnglRus=!_choceEnglRus;
            _langWorkout="rus";
            Navigator.of(context).pop();
            print('_choceEngl$_choceEngl');
          });
        },
      );
    }
    Widget _choiceEnlRus(){return
      ChoiceChip(label: Text("English/Rus"), selected: _choceEnglRus,
        onSelected: (value){
          setState(() {
            _choceEnglRus=!_choceEnglRus;
            if(_choceEngl)_choceEngl=!_choceEngl;
            if(_choceRus)_choceRus=!_choceRus;
            _langWorkout="eng/rus";
            Navigator.of(context).pop();

            print('_choceEngl$_choceEngl');
          });
        },
      );
    }
    Widget _choceList() {
      if (_choceEngl) {
        return Column(
          children: [
            _choiceRus(), _choiceEnlRus()
          ],
        );
      }
      if (_choceRus) {
        return
          Column(
            children: [_choiceEngl(), _choiceEnlRus()],
          );
      }
      if (_choceEnglRus) {
        return
          Column(
            children: [_choiceEngl(), _choiceRus()],
          );
      }
      return Text("Text");
    }



    // TODO: implement build
  int  _value=2;

    return Scaffold(

      appBar: AppBar(title:Text("Workout"),actions: <Widget> [
        IconButton(
          icon: Icon(Icons.language),
          onPressed: (){
            showDialog(context: context,
                builder: (BuildContext context){
              return AlertDialog(
                title: Text("выбор языка"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop()
                  ),
                  TextButton(
                      child: Text('Save'),
                      onPressed: () => {_rusianWorkout=true, }
                  )
                ],
                content:
                 _choceList(),
              );
                },);
          },
        ),
        Text(_langWorkout),
        IconButton(icon: Icon(Icons.not_started_outlined), onPressed: (){
          setState(() {
           // refreshIndexRnd();
            indexWork=0;
          });


        }),
      ],),
      body:  Column(
        children: [
          Row(
            children: [
              wordQuestion(),


              IconButton(icon: Icon(Icons.edit), onPressed: (){}),
              Text(indexWork.toString()),
              Text('  rating='),
              Text(_tasks[rndIndex![indexWork]].rating.toString()),
              Text('   lesson:'),
              Text(_tasks[rndIndex![indexWork]].lesson.toString())
            ],
          ),
         Container(height: 100,),
         Row(
           children: [
             Expanded(child: TextField(
               controller: answerController,
                 style:TextStyle(fontSize: 30, color: Colors.black) ,
             )),
             ElevatedButton.icon(onPressed: (){
               checkAnswer(context);
             },

                 icon: Icon(Icons.wb_incandescent_outlined), label: Text('?'))
           ],
         ),
          Container(height: 50,),
         Row(
           children: [
             ElevatedButton(onPressed: (){
               _tasks[rndIndex![indexWork]].rating=ratingMax;
               nextWord();  },
              child: Text("Знаю")),
             Container(width: 150,),
             ElevatedButton(onPressed: (){
               noKhowAnswer();
             },
                 child: Text("НеЗнаю")),
           ],
         ),
          Row(
            children: [
              ElevatedButton(onPressed: (){
             backWord(); },
                  child: Text("назад")),
              Container(width: 150,),
              ElevatedButton(onPressed: (){ nextWord();},
                  child: Text("вперед")),
            ],
          ),
         /* Row(
            children:[
             Container(
               width: 300, height: 200,
               child: _image == null
                 ? Center(child: Text('No image selected.'))
                 : Image.file(_image),),
              IconButton(icon: Icon(Icons.edit), onPressed: (){getImage();}),
    ]
          ),

          */

         /* Container(width: 300, height: 200,
            child:_image2==null?
            Text('w'): Image.file(_image2),
            // ,



                   //
          )

          */

        ],
      )


    );

    throw UnimplementedError();
  }

  }
  class RefreshModel extends ChangeNotifier{
  bool _update= false;
  int _counter=0;
  bool get update => _update;
  void set update(bool value) {
    _update=value;
    _counter++;
  notifyListeners();
  }
  void counter(){
    _counter++;
  }
  }

