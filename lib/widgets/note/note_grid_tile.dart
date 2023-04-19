import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paper/models/note.dart';
import 'package:paper/pages/note/note_workspace.dart';
import 'package:paper/pages/note/view_note_page.dart';
import 'package:paper/services/notes/notes_local_service.dart';
import 'package:paper/widgets/action_sheet.dart';
import 'package:paper/widgets/confirmation_dialog.dart';
import 'package:paper/widgets/toast.dart';

class NoteGridTile extends StatelessWidget {
  final Note note;
  const NoteGridTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewNotePage(
                      note: note,
                    )));
      },
      onLongPress: () {
        showActionSheet(context, [
          ActionSheetItem(
              title: "Open",
              icon: const Icon(BootstrapIcons.fullscreen),
              onClick: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewNotePage(
                              note: note,
                            )));
              }),
          ActionSheetItem(
              title: "Edit",
              icon: const Icon(BootstrapIcons.pencil_square),
              onClick: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteWorkspace(
                              note: note,
                            )));
              }),
          ActionSheetItem(
              title: note.favorite ? "Remove from favorite" : "Add to favorite",
              icon: const Icon(BootstrapIcons.heart),
              onClick: () {
                Navigator.pop(context);
                NotesLocalService.toggleFavorite(note);
              }),
               ActionSheetItem(
            title: "Copy",
            onClick: () async {
              Navigator.pop(context);
              Note copy = Note(
                  title: note.title,
                  content: note.content,
                  favorite: false,
                  modifiedOn: DateTime.now(),
                  createdOn: DateTime.now());
              await NotesLocalService.createNote(copy);
              if (context.mounted) {
                showToast(context, "Copy created");
              }
            },
            icon: const Icon(BootstrapIcons.files),
          ),
          ActionSheetItem(
              title: "Delete",
              isDestructive: true,
              icon: const Icon(BootstrapIcons.trash3),
              onClick: () async {
                Navigator.pop(context);
                final confirmed = await showDialog(
                  context: context,
                  builder: (context) => const ConfirmationDialog(
                    destructive: true,
                    title: 'Delete',
                    message: 'Are you sure you want to delete this note ?',
                    confirmText: 'Delete',
                    cancelText: 'Cancel',
                  ),
                );
                if (confirmed == true) {
                  // delete note
                  NotesLocalService.deleteNote(note);
                }
              }),
        ]);
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(20),
            borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Modified On \n${DateFormat("E, dd MMM yyyy").format(note.modifiedOn)}",
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                Icon(
                  note.favorite
                      ? BootstrapIcons.heart_fill
                      : BootstrapIcons.heart,
                  color: note.favorite
                      ? const Color(0xFFFF2D55)
                      : Colors.transparent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
