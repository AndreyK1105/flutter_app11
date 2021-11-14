import 'package:flutter/material.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:sqflite/sqflite.dart';

abstract class Db{
  static Database? _db;
  static int get _version=> 1;
  static String english='english';

  static Future <void> init()async{
    if(_db!=null){print("**************db!=null*******************"); return;}
    try{
      String _path= await getDatabasesPath()+"example";
      print("PATH*****************$_path");
      _db =await openDatabase(_path, version: _version, onCreate: onCreate);
          }
    catch(ex){
      print(ex);
    }
  }
  static void onCreate(Database db, int version) async=>
      await db.execute('CREATE TABLE word_item (id INTEGER PRIMARY KEY NOT NULL, english STRING, russia STRING, transcr STRING, dataAdd INTEGER, rating INTEGER, lesson INTEGER, complete BOOLEAN)');
  static Future<List<Map<String, dynamic>>> query(String table) async => _db!.query(table  );
  static Future<List<Map<String, dynamic>>> searchQuery(String table, String search) async =>
      _db!.query(table, columns: ['english','russia','transcr','dataAdd','rating','lesson','complete'] , where: 'english LIKE ?',
          whereArgs: ['%$search%'] );

  static Future<List<Map<String, dynamic>>> searchQueryRus(String table, String search) async =>
      _db!.query(table, columns: ['english','russia','transcr','dataAdd','rating','lesson','complete'] , where: 'russia LIKE ?',
          whereArgs: ['%$search%'] );

  static Future<List<Map<String, dynamic>>> searchQueryFilter(String table, List <int> filter) async {
List<Map <String, dynamic>> listMap= [];


for (int i=0; i < filter.length.toInt(); i++ ){
  listMap.addAll( await _db!.query(table, columns: ['english','russia','transcr','dataAdd','rating','lesson','complete'] ,
      where: 'lesson LIKE ?',
      whereArgs: ['%${filter[i]}%'] ) );
}
   return listMap;
  }


  static Future<int> insert(String table, Word word) async =>
      await _db!.insert(table, word.toMap());

  static Future<int> update(String table, Word word) async =>
      await _db!.update(table, word.toMap(), where: 'id = ?', whereArgs: [word.id]);

  static Future<int> delete(String table, Word word) async =>
      await _db!.delete(table, where: 'id = ?', whereArgs: [word.id]);
}