import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int index) onSelect;
  const CategoryBar(
      {super.key,
      required this.categories,
      required this.onSelect,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: categories
            .map((e) => Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      onSelect(categories.indexOf(e));
                    },
                    child: Chip(
                        backgroundColor: selectedIndex == categories.indexOf(e)
                            ? const Color(0xFF007AFF)
                            : null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        label: Text(
                          e,
                          style: TextStyle(
                              color: selectedIndex == categories.indexOf(e)
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFF9E9E9E)),
                        )),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
