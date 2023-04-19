import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paper/pages/note/note_workspace.dart';
import 'package:paper/tabs/home_tab.dart';
import 'package:paper/tabs/settings_tab.dart';
import 'package:paper/utils/page_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;
  List<Widget> tabs = const [HomeTab(), SettingsTab()];

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(
          context,
          [
            AppBar(
              title: const Text("Home"),
              actions: [
                IconButton(
                    onPressed: () {
                      goToPage(context, const NoteWorkspace());
                    },
                    icon: const Icon(BootstrapIcons.plus_lg))
              ],
            ),
            AppBar(
              title: const Text("Settings"),
            )
          ],
          currentTabIndex),
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (i) {
            currentTabIndex = i;
            // update ui
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: currentTabIndex,
          items: const [
            BottomNavigationBarItem(
                label: "Home", icon: Icon(BootstrapIcons.house)),
            BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(BootstrapIcons.gear_wide_connected)),
          ]),
    );
  }

  AppBar appBarBuilder(BuildContext context, List<AppBar> appBars, int index) {
    return appBars[index];
  }
}
