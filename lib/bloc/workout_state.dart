import 'package:flutter_app1/service/word.dart';

abstract class WorkoutState{

}

class WorkoutQuestState extends WorkoutState{
  Word word;
  WorkoutQuestState (this.word);
}
class InitState extends WorkoutState{
  Word word;
InitState(this.word);
}