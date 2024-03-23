import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:take_note/models/note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initalize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  final List<Note> currentNotes = [];

  Future<void> addNote(String note) async {
    final newNote = Note()..text = note;

    await isar.writeTxn(() => isar.notes.put(newNote)); //save db
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();

    currentNotes.clear();

    currentNotes.addAll(fetchNotes);

    notifyListeners(); //we going to notify that listens it will update screen
  }

  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = newText;

      await isar.writeTxn(() => isar.notes.put(existingNote));

      fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNotes();
  }
}
