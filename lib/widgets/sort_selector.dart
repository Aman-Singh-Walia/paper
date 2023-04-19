import 'package:flutter/material.dart';

class SortSelector extends StatelessWidget {
  final List<String> options;
  final int currentIndex;
  final Function(int) onSelect;
  const SortSelector(
      {super.key,
      required this.options,
      required this.currentIndex,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 3.0,
        icon: const Icon(Icons.sort),
        offset: const Offset(0.0, 50.0),
        itemBuilder: (context) {
          return options
              .map((e) => PopupMenuItem<int>(
                  onTap: () {
                    onSelect(options.indexOf(e));
                  },
                  value: options.indexOf(e),
                  child: Text(
                    e,
                    style: TextStyle(
                        color: options.indexOf(e) == currentIndex
                            ? Theme.of(context).primaryColor
                            : null),
                  )))
              .toList();
        });
  }
}
