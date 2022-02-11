import 'dart:math';

import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';

class WordQuestionEntiti {
  int id=0;
  int dataAdd=0;
  int rating=0;
  String question='';
  String answer='';

  WordQuestionEntiti({required this.id, required this.dataAdd, required this.rating, required this.question, required this.answer });

  static WordQuestionEntiti getEnglQuest (WordEntiti wordEntiti){
    return WordQuestionEntiti(
        id: wordEntiti.id,
        dataAdd: wordEntiti.dataAdd,
        rating: wordEntiti.rating,
        question: wordEntiti.english,
        answer: wordEntiti.russia);
  }

  static WordQuestionEntiti getRusQuest (WordEntiti wordEntiti){
    return WordQuestionEntiti(
        id: wordEntiti.id,
        dataAdd: wordEntiti.dataAdd,
        rating: wordEntiti.rating,
        question: wordEntiti.russia,
        answer: wordEntiti.english);
  }

  static WordQuestionEntiti getEnglRusQuest (WordEntiti wordEntiti){
String quest='';
String answ='';
    Random rnd = Random();
    if (rnd.nextInt(2) == 0) {
      quest=wordEntiti.russia;
      answ= wordEntiti.english;

    }
    else {
       quest=wordEntiti.english;
       answ= wordEntiti.russia;
    }

    return WordQuestionEntiti(


        id: wordEntiti.id,
        dataAdd: wordEntiti.dataAdd,
        rating: wordEntiti.rating,
        question: quest,
        answer: answ);
  }
}