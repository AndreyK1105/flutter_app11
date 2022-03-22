import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'helper_list_turn_state.dart';
part 'helper_list_turn_cubit.freezed.dart';

class HelperListTurnCubit extends Cubit<HelperListTurnState> {
  HelperListTurnCubit() : super(HelperListTurnState.hiden());
  void helperListTurnOn(){
    emit(HelperListTurnState.visibl());
  }
  void helperListTurnOff(){
    emit(HelperListTurnState.hiden());
  }
}
