import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:srg_notes/db/notes_db.dart';
import 'package:srg_notes/model/notes_model.dart';
import 'package:srg_notes/screens/add_note.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    NotesDb.instance.refreshUI();
    print("notes db loaded");
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote())); 
      },backgroundColor: Colors.green,child: Icon(Icons.add,color: Colors.black,),),
      appBar: AppBar(
        toolbarHeight: 85,
        elevation: 0,
        title: Center(child: Text("SRG Notes",style: TextStyle(color: Colors.yellow,fontStyle: FontStyle.italic),),),backgroundColor: Colors.transparent,),
      backgroundColor: Colors.black,
      body: SafeArea(child:
       SingleChildScrollView(
         child: ValueListenableBuilder(
          valueListenable :NotesDb.instance.notesListNotifier,
          builder: (context, value, child) =>Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              children: List.generate(value.length, (index) {
                                if (index.isEven) {
                                  return NoteWidget(
                                    id: value[index].id,
                                    title: value[index].title,
                                    content: value[index].content,
                                  );
                                }
                                return const SizedBox(
                                  height: 15,
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(value.length, (index) {
                                if (index.isOdd) {
                                  return Column(
                                    children: [
                                      NoteWidget(
                                        id: value[index].id,
                                        title: value[index].title,
                                        content: value[index].content,
                                                              
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  );
                                  
                                }
                                return const SizedBox(
                                  width: 15,
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
         ),
       )
       ),
    );
  }
}

class NoteWidget extends StatelessWidget {

  final String title;
  final String content;
  final String id;
  const NoteWidget({super.key, required this.title, required this.content, required this.id});
  


  @override
  Widget build(BuildContext context) {
   
final colors = const [
    Color.fromRGBO(205, 255, 166, 1),
    Color.fromRGBO(243, 224, 158, 1),
    Color.fromRGBO(165, 234, 255, 1),
    Color.fromRGBO(242, 157, 224, 1),
    Color.fromRGBO(213, 157, 255, 1),
  ];
  final random=Random();



    return GestureDetector(
      onTap: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote(id: id,content: content,title: title,)));
      },
      onLongPress: (){
        showCupertinoModalPopup(context: context, builder: (context){
          return CupertinoActionSheet(
                  //title: Text(''),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        // Handle action 1
                        NotesDb.instance.deleteNotesfromdb(id);
                        NotesDb.instance.refreshUI();
                        Navigator.pop(context);
                      },
                      child: Text('Delete',style: TextStyle(color: Colors.red),),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                );
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors[random.nextInt(colors.length)],
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
          textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            child: Text(content,
            maxLines: 7,
            overflow: TextOverflow.fade,style: TextStyle(height: 2),
            ),
          )
        ],),
      ),
    );
  }
}
