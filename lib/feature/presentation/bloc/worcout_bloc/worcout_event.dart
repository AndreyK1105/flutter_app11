part of 'worcout_bloc.dart';

@freezed

class WorcoutEvent with _$WorcoutEvent{
  const factory WorcoutEvent.next() = WorcoutEventNext;
  const factory WorcoutEvent.prev() = WorcoutEventPrev;
  const factory WorcoutEvent.check({required String examination, required WordQuestionEntiti wordQuestionEntiti,
  required List<WordQuestionEntiti> helper}) = WorcoutEventCheck;
  const factory WorcoutEvent.checkText({required String examination,  required WordQuestionEntiti wordQuestionEntiti}) = WorcoutEventCheckText;
  const factory WorcoutEvent.loading() =WorcoutEventLoading;
}