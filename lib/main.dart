import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_note/pages/notes_page.dart';
import 'package:take_note/theme/theme_provider.dart';
import 'models/note_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initalize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteDatabase()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
