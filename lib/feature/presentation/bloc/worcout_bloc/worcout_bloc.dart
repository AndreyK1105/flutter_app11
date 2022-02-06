import 'package:flutter_app1/feature/data/repositories/repo_word.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'worcout_bloc.freezed.dart';
part 'worcout_bloc.g.dart';
part 'worcout_event.dart';
part 'worcout_state.dart';

class WorcoutBloc extends Bloc <WorcoutEvent, WorcoutState>{
 final RepoWord repoWord;
  WorcoutBloc({required this.repoWord}) : super(WorcoutState.loading()){
   on<WorcoutEventNext>(event, emit){
    WordEntiti wordEntiti= repoWord.getNextWord();
    emit (WorcoutState.next(WordEntiti: wordEntiti));
   };
 on<WorcoutEventCheck>(event, emit){
    emit(WorcoutState.check());
 }
}

}