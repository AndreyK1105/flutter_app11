import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'helper_list_turn_state.dart';
part 'helper_list_turn_cubit.freezed.dart';

class HelperListTurnCubit extends Cubit<HelperListTurnState> {
  HelperListTurnCubit() : super(const HelperListTurnState.visibl());

  // void helperListTurnOn() {
  //   emit(const HelperListTurnState.hiden());
  //   print(HelperListTurnCubit().state);
  // }

  void helperListTurnOff() {
    emit(HelperListTurnState.hiden());
  }

  void helperListTurnSwith() {
    if (HelperListTurnCubit().state is HelperListTurnVisibl) {
      emit(HelperListTurnState.hiden());
      print('hiden');
    } else {
      emit(HelperListTurnState.visibl());
      print('visibl');
    }
print(HelperListTurnCubit().state);
  }
}
