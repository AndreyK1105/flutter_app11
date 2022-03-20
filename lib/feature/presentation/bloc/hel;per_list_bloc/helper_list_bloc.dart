import 'package:flutter_app1/feature/presentation/bloc/worcout_bloc/worcout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'helper_list_bloc.freezed.dart';
part 'helper_list_event.dart';
part 'helper_list_state.dart';

class HelperListBloc extends Bloc <HelperListEvent, HelperListState>{
  final WorcoutBloc worcoutBloc;

  HelperListBloc({required this.worcoutBloc}): super(HelperListState.visibl()){
    on<HelperListEventHiden>((event, emit){



      emit(HelperListState.hiden());

    }
    );
  }
}