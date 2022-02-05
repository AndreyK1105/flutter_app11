import 'package:flutter_app1/service/word.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'userFr.freezed.dart';
part 'userFr.g.dart';
@freezed
class UserFr with _$UserFr{
  const UserFr._();
  const factory UserFr ({
    @Default ('word_item') String table,
    @Default(0) int id ,
    @Default ('') String english,
    @Default ('') String russia,
    @Default ('') String transcr,
    @Default (0) int dataAdd,
    @Default (0) int rating,
    @Default (0) int lesson,
    @Default (false) bool complete

  })=_UserFr;
  factory UserFr.fromJson(Map<String, dynamic> json)=> _$UserFrFromJson(json);

  static UserFr fromString (String string){
    String str=string.trimLeft();
    int index =str.indexOf(" ");
    int idd = int.parse(str.substring(0, index));
    List<String> split=(str.substring(index+1)).split(' -');
    String rus=split[1];
    int end=rus.length-3;
    return UserFr(
        id: idd,
        english:split[0],
        russia: rus.substring(0, end)
       );
  }


}