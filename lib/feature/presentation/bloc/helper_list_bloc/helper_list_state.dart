
part of 'helper_list_bloc.dart';

@freezed
class HelperListState with _$HelperListState{
  const factory HelperListState.hiden()=HelperListStateHiden;
  const factory HelperListState.visibl()=HelperListStateVisibl;

}