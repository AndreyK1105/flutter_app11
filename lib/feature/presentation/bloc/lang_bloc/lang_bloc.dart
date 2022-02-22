import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'lang_bloc.freezed.dart';
part 'lang_event.dart';
part 'lang_state.dart';

class LangBloc extends Bloc <LangEvent, LangState>{
  LangBloc(): super(const LangState.engl()){
    on<LangEventEngl>((event, emit){
      emit (const LangState.engl());
    });
    on <LangEventRus> ((event, emit){
      emit (const LangState.rus());
    });
    on<LangEventEnglRus> ((event, emit){
      emit(const LangState.englrus());
    });
  }
  @override
  LangState onChange(Change<LangState> change){
    super.onChange(change);
    return change.nextState;
    print(change);
  }
}
