import 'package:flutter_bloc/flutter_bloc.dart';

class CubitHelper extends Cubit <CubitHelperState>{
  CubitHelper():super(CubitHelperState(onOff: false));
  CubitHelperState cubitHelperState=CubitHelperState(onOff: false);
  void helperListTurnOn() {

    cubitHelperState.onOff=true;
    emit( CubitHelperState(onOff: true));
    print(CubitHelper().state.onOff);
  }
}
 class CubitHelperState {
  late  bool onOff;
  CubitHelperState({required this.onOff});
 }

// class CubitHelpVisibl extends CubitHelperState {}
// class CubitHelpHiden extends CubitHelperState{}