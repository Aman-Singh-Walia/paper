import 'package:flutter/material.dart';
import 'package:paper/services/local_storage/local_storage_service.dart';

class SettingsService {
  static ValueNotifier<String> themeMode = ValueNotifier<String>(
      LocalStorageService.prefs.getString("themeMode") ?? "system");
  static ValueNotifier<String> viewMode = ValueNotifier<String>(
      LocalStorageService.prefs.getString("viewMode") ?? "list");
}
