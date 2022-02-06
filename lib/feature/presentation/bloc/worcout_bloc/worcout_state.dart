part of 'worcout_bloc.dart';

@freezed

class WorcoutState with _$WorcoutState{

  const factory WorcoutState.next ({required WordEntiti wordEntiti}) = WorcoutStateNext;
  const factory WorcoutState.prev ({required WordEntiti wordEntiti}) = WorcoutStatePrev;
  const factory WorcoutState.check ({required Answer answer}) = WorcoutStateCheck;
  const factory WorcoutState.loading()=WorcoutStateLoading;

}

