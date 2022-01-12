import 'package:flutter_app1/bloc/workout_event.dart';
import 'package:flutter_app1/bloc/workout_state.dart';
import 'package:flutter_app1/service/repositories/wordRepository.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutBloc extends Bloc <WorkoutEvent, WorkoutState> {
  Word word = Word(id: 0, english:''  , russia: '' , transcr: 'transcr', complete: true,
      dataAdd: 0, rating: 0, lesson: 0);
  WordRepository repository;
  WorkoutBloc(this.repository) : super(InitState()){

    Word word1=Word(id: 1, english: 'first', russia: 'первый', transcr: '',
    complete: true, dataAdd: 1, rating: 2, lesson: 1);;
    Future <List <Word>> word = repository.getWord();
  word.then((value) =>{  word1 = value[0]});
    on<WorkoutNextEvent>((event, emit) async {

       emit(WorkoutQuestState(word1));
});
    on<WorkoutPrewEvent>((event, emit)  {

      Word word = Word(id: 2, english: 'two', russia: 'второй', transcr: '',
               complete: true, dataAdd: 1, rating: 2, lesson: 1);
      emit(WorkoutQuestState(word));
});
  }

}