part of 'helper_list_bloc.dart';
@freezed
class HelperListEvent with _$HelperListEvent{
  const factory HelperListEvent.hiden()=HelperListEventHiden;
  const factory HelperListEvent.visibl()=HelperListEventVisibl;
}