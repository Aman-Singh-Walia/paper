import 'package:hive_flutter/hive_flutter.dart';
import 'package:paper/models/note.dart';

class NotesLocalService {
  static final Box notesBox = Hive.box<Note>("notesBox");
  static Future<void> createNote(Note note) async {
    await notesBox.add(note);
  }

  static Future<void> toggleFavorite(Note note) async {
    note.favorite = !note.favorite;
    await note.save();
  }

  static Future<void> deleteNote(Note note) async {
    await note.delete();
  }

  static Future<void> clearData() async {
    await notesBox.clear();
  }

  static List<Note> getAllNotes() {
    List<Note> allNotes = notesBox.values.toList().cast<Note>();
    return allNotes;
  }

  static List<Note> getFavoriteNotes() {
    List<Note> allNotes = notesBox.values.toList().cast<Note>();
    List<Note> favoriteNotes =
        allNotes.where((element) => element.favorite).toList();
    return favoriteNotes;
  }

  static List<Note> getGeneralNotes() {
    List<Note> allNotes = notesBox.values.toList().cast<Note>();
    List<Note> generalNotes =
        allNotes.where((element) => element.favorite == false).toList();
    return generalNotes;
  }
}
