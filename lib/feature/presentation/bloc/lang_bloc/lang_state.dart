part of 'lang_bloc.dart';

    @freezed
    class LangState with _$LangState{

  const factory LangState.engl()=LangStateEngl;
  const factory LangState.rus()=LangStateRus;
  const factory LangState.englrus()=LangStateEnglRus;
    }