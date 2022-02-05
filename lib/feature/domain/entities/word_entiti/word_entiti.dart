import 'package:freezed_annotation/freezed_annotation.dart';
part 'word_entiti.freezed.dart';
part 'word_entiti.g.dart';

@freezed
class WordEntiti with _$WordEntiti {
  const WordEntiti._();

  const factory WordEntiti ({
    @Default ('word_item') String table,
    @Default(0) int id,
    @Default ('') String english,
    @Default ('') String russia,
    @Default ('') String transcr,
    @Default (0) int dataAdd,
    @Default (0) int rating,
    @Default (0) int lesson,
    @Default (false) bool complete,
  }) =_WordEntiti;

  factory WordEntiti.fromJson (Map<String, dynamic> json) =>
      _$WordEntitiFromJson(json);


  static WordEntiti fromString(String string) {
    String str = string.trimLeft();
    int index = str.indexOf(" ");
    int idd = int.parse(str.substring(0, index));
    List<String> split = (str.substring(index + 1)).split(' -');
    String rus = split[1];
    int end = rus.length - 3;
    return WordEntiti(
        id: idd,
        english: split[0],
        russia: rus.substring(0, end)
    );
  }
}