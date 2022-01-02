import 'package:flutter_app1/service/word.dart';

abstract class WorkoutState{

}

class WorkoutQuestState extends WorkoutState{
  Word word;
  WorkoutQuestState (this.word);
}
class InitState extends WorkoutState{
  Word word=Word(id: 0, english:''  , russia: '' , transcr: 'transcr', complete: true,
      dataAdd: 0, rating: 0, lesson: 0);
//InitState(this.word);
}