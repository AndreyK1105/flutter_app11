part of 'worcout_bloc.dart';

@freezed

class WorcoutState with _$WorcoutState{

  const factory WorcoutState.next ({required WordQuestionEntii wordQuestionEntii}) = WorcoutStateNext;
  const factory WorcoutState.prev ({required WordQuestionEntii wordQuestionEntii}) = WorcoutStatePrev;
  const factory WorcoutState.check ({required Answer answer}) = WorcoutStateCheck;
  const factory WorcoutState.loading()=WorcoutStateLoading;

}

