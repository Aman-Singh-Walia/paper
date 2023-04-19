import 'package:flutter/material.dart';
import 'package:paper/models/note.dart';
import 'package:paper/widgets/note/note_grid_tile.dart';

class NotesGridView extends StatelessWidget {
  const NotesGridView({
    super.key,
    required this.notesList,
  });

  final List<Note> notesList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        shrinkWrap: true,
        itemCount: notesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.0, crossAxisSpacing: 10.0, crossAxisCount: 2),
        itemBuilder: (context, index) {
          return NoteGridTile(
            note: notesList[index],
          );
        });
  }
}
