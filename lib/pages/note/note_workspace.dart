import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:paper/models/note.dart';
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
                  //  edit note
                  return;
                }
                // check if not editing existing note
                if (widget.note == null) {
                  // create new note
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
          Flexible(
            child: TextField(
              readOnly: readerMode,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: contentController,
              maxLines: null,
              decoration: const InputDecoration(
                  filled: false,
                  hintText: "Details...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0)),
            ),
          )
        ]),
      ),
    );
  }
}
