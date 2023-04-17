import 'package:hive_flutter/hive_flutter.dart';
import 'package:paper/models/note.dart';

class NotesLocalService {
  static final Box notesBox = Hive.box<Note>("notesBox");
}
