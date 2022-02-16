import 'dart:math';

import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_question_entiti.dart';
import 'package:flutter_app1/service/word.dart';

class RepoWord {
  List<WordEntiti> wordsEntiti=[];
int leaght=0;
  List <int> ?indexRnd;
  List <int>? rndIndex;
  int _curent =-1;
  RepoWord({required this.wordsEntiti}){
    leaght= wordsEntiti.length;
    _refreshIndexRnd(leaght);
  }

WordEntiti getNextWord(){
    if (_curent<leaght-1){
      _curent++;
    }else _curent=0;
    return wordsEntiti[rndIndex![_curent]];

 }

  WordEntiti getPrevWord(){
    if (_curent==0){
      _curent=leaght-1;
    }else _curent--;
    return wordsEntiti[rndIndex![_curent]];

  }
  List <WordEntiti> getHelpWord(){
    List<WordEntiti>halper=[];
    Random random = Random();
    int index;
  for (int i=0; i<5; i++){
    index=random.nextInt(this.leaght);
    print('index= $index');
    halper.add(wordsEntiti[index]);
  }
  return halper;
  }

  Answer getAnswer(String examination, WordQuestionEntiti wordQuestionEntiti ){
    Answer answer;
    //WordQuestionEntiti wordQuestionEntiti;
    if(examination==wordQuestionEntiti.answer){
      answer=Answer(mistake: false, answer: 'yes! => $examination');
      return answer;
    }else answer=Answer(mistake: true, answer: 'no! => ${wordQuestionEntiti.answer}');
    return answer;



    // if (examination==wordsEntiti[rndIndex![_curent]].russia){
    //    answer=Answer(mistake: false, answer: examination);
    //   return answer;
    // }else answer=Answer(mistake: true, answer: 'no! => ${wordsEntiti[rndIndex![_curent]].russia}');
    // return answer;
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

      //print('i==$i  Index==$index');
    }
  }
}
class Answer {
  bool mistake=true;
  String answer='';

  Answer({required this.mistake, required this.answer});
}