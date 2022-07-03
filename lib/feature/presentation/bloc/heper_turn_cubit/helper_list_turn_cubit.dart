import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'helper_list_turn_state.dart';
part 'helper_list_turn_cubit.freezed.dart';

class HelperListTurnCubit extends Cubit<HelperListTurnState> {
  HelperListTurnCubit() : super(const HelperListTurnState.hiden());

  void helperListTurnOn() {
    emit(const HelperListTurnState.visibl());
   // print(HelperListTurnCubit().state);
  }

  void helperListTurnOff() {
    emit(HelperListTurnState.hiden());
  }

  void helperListTurnSwith() {
    if (this.state is HelperListTurnVisibl) {
      emit(HelperListTurnState.hiden());

    } else {
      emit(HelperListTurnState.visibl());

    }
print(this.state);
  }
}
