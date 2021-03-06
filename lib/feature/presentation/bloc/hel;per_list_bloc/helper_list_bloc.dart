import 'package:flutter_app1/feature/presentation/bloc/worcout_bloc/worcout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'helper_list_bloc.freezed.dart';
part 'helper_list_event.dart';
part 'helper_list_state.dart';

class HelperListBloc extends Bloc <HelperListEvent, HelperListState>{
 // final WorcoutBloc worcoutBloc;

  HelperListBloc(): super(HelperListState.hiden()){
    on<HelperListEventHiden>((event, emit){



      emit(HelperListState.hiden());

    }
    );

    on <HelperListEventVisibl>((event, emit){
      emit(HelperListState.visibl());
    });
  }
}