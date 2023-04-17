import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paper/models/note.dart';
import 'package:paper/pages/note/note_workspace.dart';
import 'package:paper/utils/page_navigation.dart';

class ViewNotePage extends StatefulWidget {
  final Note note;
  const ViewNotePage({super.key, required this.note});

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  bool titleExpanded = false;
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteWorkspace(
                              note: widget.note,
                            )));
              },
              icon: const Icon(BootstrapIcons.pencil_square)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExpansionTile(
              textColor: const Color(0xFF007AFF),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              onExpansionChanged: (v) {
                setState(() {
                  titleExpanded = v;
                });
              },
              tilePadding: const EdgeInsets.all(0.0),
              title: Text(widget.note.title,
                  maxLines: !titleExpanded ? 1 : null,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 25.0)),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  trailing: Icon(
                    widget.note.favorite
                        ? BootstrapIcons.heart_fill
                        : BootstrapIcons.heart,
                    color: widget.note.favorite
                        ? const Color(0xFFFF2D55)
                        : Colors.transparent,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Modified On : ${DateFormat("E, dd MMM yyyy").format(widget.note.modifiedOn)}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        "Created On : ${DateFormat("E, dd MMM yyyy").format(widget.note.createdOn)}",
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 16.0,
                    width: double.infinity,
                  ),
                  Text(
                    widget.note.content,
                    style: const TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
