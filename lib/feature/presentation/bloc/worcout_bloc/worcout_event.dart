part of 'worcout_bloc.dart';

@freezed

class WorcoutEvent with _$WorcoutEvent{
  const factory WorcoutEvent.next() = WorcoutEventNext;
  const factory WorcoutEvent.prev() = WorcoutEventPrev;
  const factory WorcoutEvent.check({required String ansver}) = WorcoutEventCheck;

  const factory WorcoutEvent.loading() =WorcoutEventLoading;
}