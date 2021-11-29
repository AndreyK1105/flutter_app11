import 'dart:io';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadFile extends StatefulWidget{
  @override
  _LoadFileState createState() => _LoadFileState();
}

class _LoadFileState extends State<LoadFile> {
  List <String> list=[];




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
  @override
  Widget build(BuildContext context) {
    String string='wwww'
        'ddw'
        'ccccc \c';//loadAsset();

    void loadFile() async {
      String str='';
       final file = File('assets/word.txt');
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
      //String string='';
      String content= await rootBundle.
      loadString('assets/word.txt');
      string=string+content;
      print(string);
      return string;
    }
//print(content);

//loadFile();
   return Scaffold(
     body: Center(
       child: Column(
         children: [
           ElevatedButton(onPressed: () async { loadFile(); setState(() {

           });}, child: Text('load'),),
           Text('content:$str'),
         ],
       ),
     ),

   );

  }
}