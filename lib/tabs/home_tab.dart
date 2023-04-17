import 'package:flutter/material.dart';
import 'package:paper/models/note.dart';
import 'package:paper/services/settings/settings_service.dart';
import 'package:paper/widgets/category_bar.dart';
import 'package:paper/widgets/no_item.dart';
import 'package:paper/widgets/note/notes_grid_view.dart';
import 'package:paper/widgets/note/notes_list_view.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedCategoryIndex = 0;
  List<String> noItemMsgs = [
    "No Notes",
    "No Favorite Notes",
    "No General Notes"
  ];

  List<Note> notesList = [
    Note(
        title:
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo architecto sit expedita magnam sint. Consequatur impedit sed, esse nemo, veniam et nihil enim culpa quo atque, provident suscipit aliquid inventore?",
        content:
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo architecto sit expedita magnam sint. Consequatur impedit sed, esse nemo, veniam et nihil enim culpa quo atque, provident suscipit aliquid inventore?",
        favorite: false,
        modifiedOn: DateTime.now(),
        createdOn: DateTime.now()),
    Note(
        title: "title2",
        content:
            "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Debitis quos laborum voluptates excepturi ratione quasi ea consequatur expedita id mollitia. Deleniti illo facere minus quam nisi magnam perspiciatis sit enim.",
        favorite: false,
        modifiedOn: DateTime.now(),
        createdOn: DateTime.now()),
    Note(
        title: "title 3",
        content:
            "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Debitis quos laborum voluptates excepturi ratione quasi ea consequatur expedita id mollitia. Deleniti illo facere minus quam nisi magnam perspiciatis sit enim.",
        favorite: true,
        modifiedOn: DateTime.now(),
        createdOn: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryBar(
          categories: const ["All", "Favorite", "General"],
          onSelect: (i) {
            setState(() {
              selectedCategoryIndex = i;
            });
          },
          selectedIndex: selectedCategoryIndex,
        ),
        notesList.isEmpty
            ? Expanded(
                child: NoItem(
                  msg: noItemMsgs[selectedCategoryIndex],
                ),
              )
            : ValueListenableBuilder(
                valueListenable: SettingsService.viewMode,
                builder: (context, viewModeVal, child) {
                  return viewModeVal == "grid"
                      ? NotesGridView(notesList: notesList)
                      : NotesListView(notesList: notesList);
                })
      ],
    );
  }
}
