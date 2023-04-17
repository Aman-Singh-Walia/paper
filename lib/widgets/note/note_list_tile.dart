import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paper/models/note.dart';
import 'package:paper/pages/note/note_workspace.dart';
import 'package:paper/pages/note/view_note_page.dart';
import 'package:paper/widgets/action_sheet.dart';
import 'package:paper/widgets/confirmation_dialog.dart';

class NoteListTile extends StatelessWidget {
  final Note note;
  const NoteListTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
                // toggle note favorite
              }),
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
                }
              }),
        ]);
      },
      trailing: note.favorite
          ? const Icon(
              BootstrapIcons.heart_fill,
              color: Color(0xFFFF2D55),
            )
          : null,
      title: Text(
        note.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "Modified On : ${DateFormat("E, dd MMM yyyy").format(note.modifiedOn)}",
        style: const TextStyle(
          fontSize: 12.0,
        ),
      ),
    );
  }
}
