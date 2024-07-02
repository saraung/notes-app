

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:srg_notes/model/notes_model.dart';



const NOTES_DB_NAME="transaction-db";

abstract class NotesDbFunctions {
 
  
  Future<void> addNotestodb(NotesModel obj);
   Future<List<NotesModel>> getNotes();
   Future<void> deleteNotesfromdb(String Notesid);
}


class NotesDb implements NotesDbFunctions{

  NotesDb._internal();

  static NotesDb instance = NotesDb._internal();
  factory NotesDb (){
    return instance;
  }



  @override
  Future<void> addNotestodb(NotesModel obj) async{
    final _db=await Hive.openBox<NotesModel>(NOTES_DB_NAME);
    await _db.put(obj.id,obj);
    
   

  }



  ValueNotifier<List<NotesModel>> notesListNotifier=ValueNotifier([]);

  Future<List<NotesModel>> getNotes() async {
    final _TransactionDB = await Hive.openBox<NotesModel>(NOTES_DB_NAME);
    return _TransactionDB.values.toList();
  }


  Future<void> refreshUI() async {
    final _list = await getNotes();
    notesListNotifier.value.clear();
    notesListNotifier.value=_list;
    notesListNotifier.notifyListeners();
  }

    Future<void> deleteNotesfromdb(String Notesid) async {
     final _DB = await Hive.openBox<NotesModel>(NOTES_DB_NAME);
     await _DB.delete(Notesid);
     refreshUI();
   }


}