import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'notes_model.g.dart';



@HiveType(typeId: 0)
class NotesModel {

  @HiveField(0)
   final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String  content;

  @HiveField(3)
  final DateTime? dateTime;

  NotesModel({required this.id, required this.title, required this.content, this.dateTime});

  

}


