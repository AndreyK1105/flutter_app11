import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_question_entiti.dart';
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

  WorcoutBloc({required this.repoWord}) : super(WorcoutState.loading()){
   on<WorcoutEventNext>((event, emit){
    WordEntiti wordEntiti= repoWord.getNextWord();
   // WordQuestionEntii wordQuestionEntii= WordQuestionEntii.getEnglQuest(wordEntiti);
    emit (WorcoutState.next(wordQuestionEntii: WordQuestionEntii.getEnglRusQuest(wordEntiti)));
   });
   on<WorcoutEventPrev>((event, emit){
     WordEntiti wordEntiti= repoWord.getPrevWord();
     emit(WorcoutState.prev(wordQuestionEntii: WordQuestionEntii.getEnglQuest(wordEntiti)));
   });

 on<WorcoutEventCheck>((event, emit){

    emit(WorcoutState.check(answer:
    repoWord.getAnswer(event.ansver)));
 });
}

}
//flutter pub run build_runner watch --delete-conflicting-outputs