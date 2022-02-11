part of 'lang_bloc.dart';

@freezed
class LangEvent with _$LangEvent{
  const factory LangEvent.engl()=LangEventEngl;
  const factory LangEvent.rus()=LangEventRus;
  const factory LangEvent.englrus()=LangEventEnglRus;
    }