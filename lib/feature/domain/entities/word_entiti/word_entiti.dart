import 'package:flutter_app1/service/word.dart';
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

static Word getWord(WordEntiti wordEntiti){
            Word word =Word(
              id: wordEntiti.id,
              english: wordEntiti.english,
              russia: wordEntiti.russia,
              rating: wordEntiti.rating,
              lesson: wordEntiti.lesson,
              transcr: wordEntiti.transcr,
              dataAdd: wordEntiti.dataAdd,
              complete: wordEntiti.complete
            );

  return word;
}

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
 static List<WordEntiti>  fromWord (List<Word> word){
    List<WordEntiti> wordEntiti= [];
    print(word.length);
    word.forEach((element) { wordEntiti.add(WordEntiti(id: element.id, english: element.english, russia: element.russia,
    rating: element.rating, transcr: element.transcr, lesson: element.lesson));});
    print(wordEntiti.length);
    return wordEntiti;
 }

}