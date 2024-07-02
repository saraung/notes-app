import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:srg_notes/model/notes_model.dart';
import 'package:srg_notes/screens/home_screen.dart';

Future<void> main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

   if(!Hive.isAdapterRegistered(NotesModelAdapter().typeId)){
   Hive.registerAdapter(NotesModelAdapter());
   }

  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:HomeScreen() ,);
  }
}
