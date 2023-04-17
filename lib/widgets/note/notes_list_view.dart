import 'package:flutter/material.dart';
import 'package:paper/models/note.dart';
import 'package:paper/widgets/note/note_list_tile.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.notesList,
  });

  final List<Note> notesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          return NoteListTile(
            note: notesList[index],
          );
        });
  }
}
