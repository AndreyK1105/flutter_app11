import 'dart:math';

import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';

class WordQuestionEntii {
  int id=0;
  int dataAdd=0;
  int rating=0;
  String question='';
  String answer='';

  WordQuestionEntii({required this.id, required this.dataAdd, required this.rating, required this.question, required this.answer });

  static WordQuestionEntii getEnglQuest (WordEntiti wordEntiti){
    return WordQuestionEntii(
        id: wordEntiti.id,
        dataAdd: wordEntiti.dataAdd,
        rating: wordEntiti.rating,
        question: wordEntiti.english,
        answer: wordEntiti.russia);
  }

  static WordQuestionEntii getRusQuest (WordEntiti wordEntiti){
    return WordQuestionEntii(
        id: wordEntiti.id,
        dataAdd: wordEntiti.dataAdd,
        rating: wordEntiti.rating,
        question: wordEntiti.russia,
        answer: wordEntiti.english);
  }

  WordQuestionEntii getEnglRusQuest (WordEntiti wordEntiti){
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

    return WordQuestionEntii(


        id: wordEntiti.id,
        dataAdd: wordEntiti.dataAdd,
        rating: wordEntiti.rating,
        question: quest,
        answer: answ);
  }
}