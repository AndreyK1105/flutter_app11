import 'package:flutter_app1/bloc/workout_event.dart';
import 'package:flutter_app1/bloc/workout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutBloc extends Bloc <WorkoutEvent, WorkoutState> {
  WorkoutBloc(WorkoutState initialState) : super(initialState);

}