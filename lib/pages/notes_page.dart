import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:take_note/app_const.dart';
import 'package:take_note/components/drawer.dart';
import 'package:take_note/components/note_tile.dart';
import 'package:take_note/models/note_database.dart';

import '../models/note.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  final noteController = TextEditingController();

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              content: TextField(
                controller: noteController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    // add db
                    context.read<NoteDatabase>().addNote(noteController.text);
                    Navigator.pop(context);

                    noteController.clear();
                  },
                  child: Text(AppStrings.createButton),
                )
              ],
            ));
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void deleteNotes(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  void updateNote(Note note) {
    noteController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text(AppStrings.updateNote),
              content: TextField(controller: noteController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, noteController.text);
                    noteController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.update),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              AppStrings.heading,
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return NoteTileWidget(
                    text: note.text,
                    onEditPressed: () {
                      updateNote(note);
                    },
                    onDeletePressed: () {
                      deleteNotes(note.id);
                    });
              },
              itemCount: currentNotes.length,
            ),
          ),
        ],
      ),
    );
  }
}
