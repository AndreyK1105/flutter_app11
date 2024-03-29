import 'dart:async';

import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_question_entiti.dart';
import 'package:flutter_app1/feature/presentation/bloc/helper_list_bloc/helper_list_bloc.dart';
import 'package:flutter_app1/feature/presentation/bloc/heper_turn_cubit/helper_list_turn_cubit.dart';
import 'package:flutter_app1/feature/presentation/bloc/lang_bloc/lang_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'worcout_bloc.freezed.dart';
//part 'worcout_bloc.g.dart';
part 'worcout_event.dart';
part 'worcout_state.dart';

//enum Lang {ang, rus, ang_rus};

class WorcoutBloc extends Bloc <WorcoutEvent, WorcoutState>{
 final RepoWord repoWord;
 final  LangBloc langBloc;
 final HelperListTurnCubit helperListTurnCubit;
 final HelperListBloc helperListBloc;

// StreamSubscription? streamSubscription;
  WorcoutBloc({required this.repoWord, required this.langBloc, required this.helperListTurnCubit,
  required this.helperListBloc}) : super(WorcoutState.loading()){

   on<WorcoutEventNext>((event, emit){
     WordEntiti wordEntiti= repoWord.getNextWord();
    List<WordQuestionEntiti>halper=[];
 //  LangBloc stateLang=LangBloc();


    if(langBloc.state is LangStateEngl) {
      List<WordEntiti>helperWord =repoWord.getHelpWord();

      halper.add(WordQuestionEntiti.getEnglQuest(wordEntiti));


      helperWord.forEach((element) {

        ///////////



       //  if(langBloc.state is LangStateEngl){
       //    WordQuestionEntiti wordQuestionEntiti=WordQuestionEntiti.getEnglQuest(element);
       //
       //    String answ= wordQuestionEntiti.answer;
       //    String answ1=answ;
       //    String string=answ.replaceAll( '', '_');
       //
       //    wordQuestionEntiti.answer='**help**';
       //    halper.add(wordQuestionEntiti);}
        halper.add(WordQuestionEntiti.getEnglQuest(element));
        });

      //////////////////////
      halper.shuffle();


     // ignore: unnecessary_type_check
     if(helperListTurnCubit.state is HelperListTurnHiden){helperListBloc.add(const HelperListEvent.hiden());}
     else{helperListBloc.add(const HelperListEvent.visibl());}


      emit(WorcoutState.next(
          wordQuestionEntii: WordQuestionEntiti.getEnglQuest(wordEntiti), halper:halper ));
    };

    if(langBloc.state is LangStateRus) {
      print('russssss');
      print(langBloc.state);
      List<WordEntiti>helperWord =repoWord.getHelpWord();
      halper.add(WordQuestionEntiti.getRusQuest(wordEntiti));

      helperWord.forEach((element) {halper.add(WordQuestionEntiti.getRusQuest(element));});
      halper.shuffle();
      if(helperListTurnCubit.state is HelperListTurnHiden){helperListBloc.add(const HelperListEvent.hiden());}
      else{helperListBloc.add(const HelperListEvent.visibl());}
      emit(WorcoutState.next(
          wordQuestionEntii: WordQuestionEntiti.getRusQuest(wordEntiti), halper:halper));
    };

    if(langBloc.state is LangStateEnglRus) {
      WordQuestionEntiti wordQuestionEntiti = WordQuestionEntiti
          .getEnglRusQuest(wordEntiti);
      List<WordEntiti>helperWord = repoWord.getHelpWord();
      if (wordQuestionEntiti.lang) {
        halper.add(wordQuestionEntiti);
        helperWord.forEach((element) {
          halper.add(WordQuestionEntiti.getEnglQuest(element));
           });
     halper.shuffle();
      }else {
        halper.add(wordQuestionEntiti);
        helperWord.forEach((element) {
        halper.add(WordQuestionEntiti.getRusQuest(element));
              });
        halper.shuffle();
      }
      if(helperListTurnCubit.state is HelperListTurnHiden){helperListBloc.add(const HelperListEvent.hiden());}
      else{helperListBloc.add(const HelperListEvent.visibl());}
      emit(WorcoutState.next(
          wordQuestionEntii: wordQuestionEntiti, halper: halper));
    }
   });


   on<WorcoutEventPrev>((event, emit){
     WordEntiti wordEntiti= repoWord.getPrevWord();

     if(langBloc.state is LangStateEngl) {
       emit(WorcoutState.prev(
         wordQuestionEntii: WordQuestionEntiti.getEnglQuest(wordEntiti)));
     }

     if(langBloc.state is LangStateRus) {
       emit(WorcoutState.prev(
         wordQuestionEntii: WordQuestionEntiti.getRusQuest(wordEntiti)));
     }

     if(langBloc.state is LangStateEnglRus) {
       emit(WorcoutState.prev(
         wordQuestionEntii: WordQuestionEntiti.getEnglRusQuest(wordEntiti)));
     }


   });

 on<WorcoutEventCheck>((event, emit){

     Answer answer= repoWord.getAnswer(event.examination, event.wordQuestionEntiti);
     List<WordQuestionEntiti> helper= event.helper;

     for(int i=0; i<helper.length; i++){
       if (helper[i].answer==event.examination && answer.mistake){
         helper[i].colorBackgroundUnit='red';
       }
       print(answer.answer);
       if (helper[i].answer==answer.answer){
         helper[i].colorBackgroundUnit='white';
         print('white');
       }
     }

    emit(WorcoutState.check(answer: answer, halper: helper));
 });

 on<WorcoutEventCheckText>((event, emit){
   String examination= event.examination;
   Answer answer= repoWord.getAnswer(examination, event.wordQuestionEntiti);

    emit(WorcoutState.checkText(answer: answer, examinationTextField: examination));
 });
}

}
  //flutter pub run build_runner watch --delete-conflicting-outputs