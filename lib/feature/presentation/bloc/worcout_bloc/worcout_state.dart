part of 'worcout_bloc.dart';

@freezed

class WorcoutState with _$WorcoutState{
const WorcoutState._();
  const factory WorcoutState.next ({required WordQuestionEntiti wordQuestionEntii, required List<WordQuestionEntiti> halper}) = WorcoutStateNext;
  const factory WorcoutState.prev ({required WordQuestionEntiti wordQuestionEntii}) = WorcoutStatePrev;
  const factory WorcoutState.check ({required Answer answer,required List<WordQuestionEntiti> halper}) = WorcoutStateCheck;
  const factory WorcoutState.loading()=WorcoutStateLoading;

}

