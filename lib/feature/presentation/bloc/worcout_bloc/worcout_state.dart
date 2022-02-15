part of 'worcout_bloc.dart';

@freezed

class WorcoutState with _$WorcoutState{

  const factory WorcoutState.next ({required WordQuestionEntiti wordQuestionEntii, required List<WordQuestionEntiti> halper}) = WorcoutStateNext;
  const factory WorcoutState.prev ({required WordQuestionEntiti wordQuestionEntii}) = WorcoutStatePrev;
  const factory WorcoutState.check ({required Answer answer}) = WorcoutStateCheck;
  const factory WorcoutState.loading()=WorcoutStateLoading;

}

