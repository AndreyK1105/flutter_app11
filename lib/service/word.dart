import 'dart:core';

import 'dart:core';

class Word {
  static String table="word_item";
  int id=0;
   String english="--";
   String russia="--";
   String transcr="--";
   int dataAdd=0;
   int rating=0;
   int lesson=0;
   bool complete=false;




  Word ( { required this.id, required this.english, required this.russia, required this.transcr, required this.complete, required this.dataAdd,required this.rating, required this.lesson});

  Word.fromJson (Map<String, dynamic> data ){
    english=data["inglish"]==null?" ":data["inglish"];
    russia= data["russia"]==null?" ":data["russia"];
   transcr=data["transcr"]==null?" ":data["transcr"];
   complete=data["complete"]==null? false:data["complete"];
    dataAdd=data["dataAdd"]==null?" ":data["dataAdd"];
    rating=data["rating"];
    lesson=data["lesson"];
  }


  
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "english": english,
      "russia": russia,
      "transcr": transcr,
      "dataAdd": dataAdd,
      "rating": rating,
      "lesson": lesson,
    "complete": complete
    };
   // if (id!=null){map["id"]=id;}
    return map;
 }

 static Word fromMap(Map<String, dynamic>map){

    return Word(
      id: (map["id"]!=null)?map['id']:0,
      english:map["english"],
      russia: map["russia"],
      transcr: map["transcr"],
      dataAdd: map["dataAdd"],
      rating: map["rating"],
      lesson: map["lesson"],
      complete: map["complete"]==1
    );
 }
 
 static Word fromString(String string){

    String str=string.trimLeft();
    int index =str.indexOf(" ");
    int idd = int.parse(string.substring(1, index-1));
    print('idd $idd');
    print('index $index');

    return Word(
        id: idd,
        english:'',
        russia: ' ',
        transcr:' ',
        dataAdd: 0,
        rating: 0,
        lesson: 0,
        complete:false
    );
 }
  set english1(String value) {
    english = value;
  }
  /*set english(String value) {
    _english = value;
  }

  String get english => _english;

  String get transcr => _transcr;

  String get russia => _russia;

  set russia(String value) {
    _russia = value;
  }

  set transcr(String value) {
    _transcr = value;
  }
  */

}