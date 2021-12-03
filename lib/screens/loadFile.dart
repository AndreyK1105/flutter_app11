import 'dart:io';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:path_provider/path_provider.dart';

class LoadFile extends StatefulWidget{
  @override
  _LoadFileState createState() => _LoadFileState();
}

class _LoadFileState extends State<LoadFile> {
  List <String> list=[];
  List list1=[];



 pathDir() async {
  Directory tempDir = await getApplicationDocumentsDirectory();
  String tempPath = tempDir.path;
  return tempPath;
}

    /*Stream<String> lines = file.openRead()
        .transform(utf8.decoder)       // Decode bytes to UTF-8.
        .transform(LineSplitter());
    try {
      await for (var line in lines) {
        print('$line: ${line.length} characters');
      }
      print('File is now closed.');
    } catch (e) {
      print('Error: $e');
    }*/

  String str='';
  Future<void> getPath() async {
    String path = await pathDir();
    print(path);
  }

  Future<List<String>> _read() async {
    String text='';
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      print('directory.path==${directory.path}');
      //text = await file.readAsLines();
      List<String> list= await file.readAsLines();
      for (int i=0;i<list.length; i++ ){
      Word word= Word.fromString(list[i]);
        print('i=$i id word= ${word.id} engl:${word.english} rus:${word.russia} ${list[i]}');







      }
      return list;
    } catch (e) {
      print("Couldn't read file");
    }

    //print('text=$text');

    return list;
  }

  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(text);
  }
  
  @override
  Widget build(BuildContext context) {



getPath();
    //String string=_read();
     //   'ddw'
      //  'ccccc \c';//loadAsset();

    void loadFile() async {
      String str='';
       final file = File("/assets/word.txt");
       var exist = file.existsSync();
     await   file.exists();
     print(exist);
     //file.readAsString().then((String contents) {
     //   str=contents;
     // });
     //jsonDecode(str);
     //print(str);
    }



    Future<String> loadAsset() async {
      String string='';
      String content= await rootBundle.
      loadString('assets/word.txt');
      string=string+content;
      print(string);
      return string;
    }

    void writeFile() async{
      String content= await loadAsset();
      _write(content);
    }

//print(content);

//loadFile();
   return Scaffold(
     body: Center(
       child: Column(
         children: [
           Container(height: 100),
           ElevatedButton(onPressed: () async {
             Future <List> retp=_read();
             retp.then((value) => (list1=value)); setState(() {

           });}, child: Text('load'),),

           ElevatedButton(onPressed: () async { writeFile(); setState(() {

           });}, child: Text('write'),),
           
           Text('content:$str'),
         ],
       ),
     ),

   );

  }
}