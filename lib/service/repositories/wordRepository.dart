import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter_app1/service/repositories/wordDbProvider.dart';

import '../db.dart';
import '../word.dart';

class WordRepository {
  WordDbProvider _wordDbProvider=WordDbProvider();
Future <Word?> getWord(int i) async {
  try {
  final List<Word> list =await _wordDbProvider.getLoadListWord();

    return list[i];
  } catch (_){
return null;
  }
}

}