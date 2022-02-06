part of 'worcout_bloc.dart';

@freezed

class WorcoutState with _$WorcoutState{

  const factory WorcoutState.next ({required WordEntiti}) = WorcoutStateNext;
  const factory WorcoutState.prev ({required WordEntiti}) = WorcoutStatePrev;
  const factory WorcoutState.check () = WorcoutStateCheck;
  const factory WorcoutState.loading()=WorcoutStateLoading;

}