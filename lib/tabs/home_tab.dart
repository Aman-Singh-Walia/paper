import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paper/models/note.dart';
import 'package:paper/services/notes/notes_local_service.dart';
import 'package:paper/services/settings/settings_service.dart';
import 'package:paper/widgets/category_bar.dart';
import 'package:paper/widgets/no_item.dart';
import 'package:paper/widgets/note/notes_grid_view.dart';
import 'package:paper/widgets/note/notes_list_view.dart';
import 'package:paper/widgets/sort_selector.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedCategoryIndex = 0;
  int selectedSortOptionIndex = 0;
  List<String> noItemMsgs = [
    "No Notes",
    "No Favorite Notes",
    "No General Notes"
  ];
  List<String> sortOptions = [
    "Title",
    "Date modified",
    "Date created",
  ];

  List<Note> notesList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Flexible(
              child: CategoryBar(
            categories: const ["All", "Favorite", "General"],
            onSelect: (i) {
              setState(() {
                selectedCategoryIndex = i;
              });
            },
            selectedIndex: selectedCategoryIndex,
          )),
          SortSelector(
            options: sortOptions,
            currentIndex: selectedSortOptionIndex,
            onSelect: (i) {
              setState(() {
                selectedSortOptionIndex = i;
              });
            },
          )
        ]),
        ValueListenableBuilder(
            valueListenable: NotesLocalService.notesBox.listenable(),
            builder: (context, notesBox, child) {
              if (selectedCategoryIndex == 0) {
                notesList = NotesLocalService.getAllNotes();
              }

              if (selectedCategoryIndex == 1) {
                notesList = NotesLocalService.getFavoriteNotes();
              }

              if (selectedCategoryIndex == 2) {
                notesList = NotesLocalService.getGeneralNotes();
              }

              sort(notesList);
              return notesList.isEmpty
                  ? Expanded(
                      child: NoItem(
                        msg: noItemMsgs[selectedCategoryIndex],
                      ),
                    )
                  : ValueListenableBuilder(
                      valueListenable: SettingsService.viewMode,
                      builder: (context, viewModeVal, child) {
                        return viewModeVal == "grid"
                            ? Expanded(
                                child: NotesGridView(notesList: notesList))
                            : Expanded(
                                child: NotesListView(notesList: notesList));
                      });
            })
      ],
    );
  }
 
  sort(List<Note> ul) {
    if (selectedSortOptionIndex == 1) {
      NotesLocalService.sortByDateModified(ul);
    } else if (selectedSortOptionIndex == 2) {
      NotesLocalService.sortByDateCreated(ul);
    } else {
      NotesLocalService.sortByTitle(ul);
    }
  }
}
