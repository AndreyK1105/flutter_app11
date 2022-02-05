import 'dart:math';

import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/service/word.dart';

class RepoWord {
  List<WordEntiti> wordsEntiti=[];
int leaght=0;
  List <int> ?indexRnd;
  List <int>? rndIndex;
  RepoWord({required this.wordsEntiti}){
    leaght= wordsEntiti.length;
    _refreshIndexRnd(leaght);
  }

WordEntiti _getNextWord(){
    return WordEntiti();

 }


  void _refreshIndexRnd(int leght) {
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
}