import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:paper/models/note.dart';
import 'package:paper/services/notes/notes_local_service.dart';
import 'package:paper/utils/page_navigation.dart';
import 'package:paper/widgets/toast.dart';

class NoteWorkspace extends StatefulWidget {
  final Note? note;
  const NoteWorkspace({super.key, this.note});

  @override
  State<NoteWorkspace> createState() => _NoteWorkspaceState();
}

class _NoteWorkspaceState extends State<NoteWorkspace> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool readerMode = false;

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              goBack(context);
            },
            icon: const Icon(BootstrapIcons.chevron_left)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  readerMode = !readerMode;
                });
              },
              icon: Icon(
                  readerMode ? BootstrapIcons.book_fill : BootstrapIcons.book)),
          IconButton(
              onPressed: () async {
                // check if title is empty
                if (titleController.text.isEmpty) {
                  showToast(context, "Title is required.");
                  return;
                }

                // check if editing existing note
                if (widget.note != null) {
                  widget.note!.title = titleController.text.trim();
                  widget.note!.content = contentController.text;
                  widget.note!.modifiedOn = DateTime.now();
                  await widget.note!.save();
                  if (context.mounted) {
                    goBack(context);
                  }
                  return;
                }
                // check if not editing existing note
                if (widget.note == null) {
                  // create new note
                  Note newNote = Note(
                      title: titleController.text.trim(),
                      content: contentController.text,
                      favorite: false,
                      modifiedOn: DateTime.now(),
                      createdOn: DateTime.now());
                  await NotesLocalService.createNote(newNote);
                  if (context.mounted) {
                    goBack(context);
                  }
                  return;
                }
                // save note
              },
              icon: const Icon(BootstrapIcons.check2)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: Column(children: [
          TextField(
            readOnly: readerMode,
            maxLength: 100,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: titleController,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
            decoration: const InputDecoration(
                filled: false,
                hintText: "Title...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8.0),
                counterText: ""),
          ),
          Expanded(
            child: TextField(
              readOnly: readerMode,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: contentController,
              maxLines: null,
              minLines: null,
              expands: true,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                  hintText: "Details...",
                  filled: true,
                  fillColor: Colors.grey.withAlpha(20),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0)),
                  contentPadding: const EdgeInsets.all(8.0)),
            ),
          )
        ]),
      ),
    );
  }
}
