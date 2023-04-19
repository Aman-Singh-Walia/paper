import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:paper/services/local_storage/local_storage_service.dart';
import 'package:paper/services/notes/notes_local_service.dart';
import 'package:paper/services/settings/settings_service.dart';
import 'package:paper/widgets/confirmation_dialog.dart';
import 'package:paper/widgets/toast.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        // theme selector
        ValueListenableBuilder(
            valueListenable: SettingsService.themeMode,
            builder: (context, themeModeVal, child) {
              return Wrap(
                children: [
                  const SettingTitle(title: "Theme Mode"),
                  RadioListTile<String>(
                      title: const Text("System"),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: "system",
                      activeColor: const Color(0xFF007AFF),
                      groupValue: themeModeVal,
                      onChanged: (v) async {
                        await LocalStorageService.prefs
                            .setString("themeMode", "system");
                        SettingsService.themeMode.value = "system";
                      }),
                  RadioListTile<String>(
                      title: const Text("Light"),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: "light",
                      activeColor: const Color(0xFF007AFF),
                      groupValue: themeModeVal,
                      onChanged: (v) async {
                        await LocalStorageService.prefs
                            .setString("themeMode", "light");
                        SettingsService.themeMode.value = "light";
                      }),
                  RadioListTile<String>(
                      title: const Text("Dark"),
                      value: "dark",
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: const Color(0xFF007AFF),
                      groupValue: themeModeVal,
                      onChanged: (v) async {
                        await LocalStorageService.prefs
                            .setString("themeMode", "dark");
                        SettingsService.themeMode.value = "dark";
                      })
                ],
              );
            }),
        const Divider(),
        // view mode
        ValueListenableBuilder(
            valueListenable: SettingsService.viewMode,
            builder: (context, viewModeVal, child) {
              return Wrap(
                children: [
                  const SettingTitle(title: "View"),
                  RadioListTile(
                      title: const Text("List"),
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: const Color(0xFF007AFF),
                      value: "list",
                      groupValue: viewModeVal,
                      onChanged: (v) async {
                        await LocalStorageService.prefs
                            .setString("viewMode", "list");
                        SettingsService.viewMode.value = "list";
                      }),
                  RadioListTile(
                      title: const Text("Grid"),
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: const Color(0xFF007AFF),
                      value: "grid",
                      groupValue: viewModeVal,
                      onChanged: (v) async {
                        await LocalStorageService.prefs
                            .setString("viewMode", "grid");
                        SettingsService.viewMode.value = "grid";
                      })
                ],
              );
            }),
        const Divider(),
        Wrap(
          children: [
            const SettingTitle(title: "Data"),
            ListTile(
              onTap: () async {
                if (NotesLocalService.notesBox.isEmpty) {
                  showToast(context, "Nothing to clear");
                  return;
                }
                final confirmed = await showDialog(
                  context: context,
                  builder: (context) => const ConfirmationDialog(
                    destructive: true,
                    title: 'Clear Local Data',
                    message:
                        'Are you sure you want to clear all notes stored on this device ?',
                    confirmText: 'Delete',
                    cancelText: 'Cancel',
                  ),
                );
                if (confirmed == true) {
                  //clear data
                  await NotesLocalService.clearData();
                  if (context.mounted) {
                    showToast(context, "Data cleared successfully");
                  }
                }
              },
              textColor: const Color(0xFFFF3B30),
              iconColor: const Color(0xFFFF3B30),
              title: const Text("Clear local data"),
              subtitle: const Text("Clear notes stored on this device"),
              trailing: const Icon(BootstrapIcons.trash3),
            )
          ],
        ),
      ],
    );
  }
}

class SettingTitle extends StatelessWidget {
  final String title;
  const SettingTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
      ),
    );
  }
}
