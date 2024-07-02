import 'dart:math';

import 'package:flutter/material.dart';
import 'package:srg_notes/db/notes_db.dart';
import 'package:srg_notes/model/notes_model.dart';



 final colors = const [
    Color.fromRGBO(205, 255, 166, 1),
    Color.fromRGBO(243, 224, 158, 1),
    Color.fromRGBO(165, 234, 255, 1),
    Color.fromRGBO(242, 157, 224, 1),
    Color.fromRGBO(213, 157, 255, 1),
  ];
  final random=Random();

class AddNote extends StatefulWidget {
  AddNote({super.key, this.id, this.title, this.content});

  
  final String? id;
  final String? title;
  final String? content;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleTextController=TextEditingController();

  final contentTextController=TextEditingController();


  bool isEditing = false;

   @override
  void initState() {

    if (widget.title != null || widget.content != null) {
      isEditing = true;
    }
    titleTextController.text = widget.title ?? "";
    contentTextController.text = widget.content ?? "";
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: Center(child: Text(
          !isEditing ? "Add Note" : "Edit Note",style: TextStyle(color: Colors.yellow),)),
        centerTitle: true,
        actions: [!isEditing?
          IconButton(onPressed: (){
            addNotes(context);
          }, icon: Icon(Icons.check))
        :IconButton(onPressed: (){
          setState(() {
            isEditing=false;
            
          });
        },
         icon: Icon(Icons.edit))],
        ),
        backgroundColor: colors[random.nextInt(colors.length)],
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
        children: [
          TextField(
            enabled: !isEditing,
            controller: titleTextController,
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(fontWeight: FontWeight.bold),
             contentPadding: EdgeInsets.all(15),
            ),
            style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
            
          ),
          Container(
            height: 2000,
            child: TextField(
              enabled: !isEditing,
              controller: contentTextController,
              decoration: InputDecoration(
                hintText: "Description",
                 border: InputBorder.none,
                 contentPadding: EdgeInsets.all(15),
              ), 
              style: const TextStyle(
                  fontSize: 20,
                 color: Colors.black
                  
                ),
              expands: true,           
            minLines: null,
            maxLines: null,
            ),
          )
        ],
            ),
      )),
    );
  }

  Future<void> addNotes(BuildContext ctx) async {
  if(titleTextController.text.isEmpty || contentTextController.text.isEmpty) {
    return;
  }
  
  
  final _notemodel = NotesModel(
    id: widget.id != null? widget.id.toString() :DateTime.now().millisecondsSinceEpoch.toString(),
    title: titleTextController.text,
    content: contentTextController.text,
    dateTime: DateTime.now(),
  );
  
  await NotesDb.instance.addNotestodb(_notemodel);

  print("note added");
  NotesDb.instance.refreshUI();
  Navigator.of(ctx).pop();
}
}