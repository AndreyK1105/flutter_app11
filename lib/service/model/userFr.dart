import 'package:freezed_annotation/freezed_annotation.dart';

part 'userFr.freezed.dart';
part 'userFr.g.dart';
@freezed
class UserFr with _$UserFr{
  const factory UserFr ({int? value, String? name})=_UserFr;
  factory UserFr.fromJson(Map<String, dynamic> json)=> _$UserFrFromJson(json);
}