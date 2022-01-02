import 'dart:core';
import 'dart:core';
import 'dart:core';

import '../db.dart';
import '../word.dart';

class WordRepository {
 // late Word _word;

 // late List<Word> _listWord;


  Future<List<Word>> getLoadListWord() async{
   // List <Word> _listWord;
    List <Map<String, dynamic>> _results = await Db.query(Word.table);
    List<Word> listWord= _results.map((item) => Word.fromMap(item)).toList();
    return  listWord ;
  }
}