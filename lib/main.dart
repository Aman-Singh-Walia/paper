import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paper/pages/home/home_page.dart';
import 'package:paper/services/local_storage/local_storage_service.dart';
import 'package:paper/services/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init local storage
  await LocalStorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: SettingsService.themeMode,
        builder: (context, themeModeVal, child) {
          return MaterialApp(
            themeMode: themeModeVal == "light"
                ? ThemeMode.light
                : themeModeVal == "dark"
                    ? ThemeMode.dark
                    : ThemeMode.system,
            title: 'Paper',
            theme: ThemeData(
                primaryColor: const Color(0xFF007AFF),
                brightness: Brightness.light,
                scaffoldBackgroundColor: const Color(0xfffafafa),
                appBarTheme: const AppBarTheme(
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    backgroundColor: Color(0xfffafafa),
                    iconTheme: IconThemeData(color: Color(0xFF007AFF)),
                    actionsIconTheme: IconThemeData(color: Color(0xFF007AFF)),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness: Brightness.dark)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  elevation: 0.0,
                  backgroundColor: Color(0xfffafafa),
                  selectedItemColor: Color(0xFF007AFF),
                ),
                inputDecorationTheme: InputDecorationTheme(
                    isDense: true,
                    filled: true,
                    contentPadding: const EdgeInsets.all(10.0),
                    fillColor: const Color(0xFFEFEFF4),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0))),
                buttonTheme:
                    const ButtonThemeData(buttonColor: Color(0xFF007AFF)),
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Color(0xfffafafa)),
                dialogTheme: DialogTheme(
                    backgroundColor: const Color(0xfffafafa),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16.0),
                        elevation: 0.0,
                        backgroundColor: const Color(0xFF007AFF))),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16.0),
                        foregroundColor: const Color(0xFF007AFF))),
                progressIndicatorTheme:
                    const ProgressIndicatorThemeData(color: Color(0xFF007AFF))),
            darkTheme: ThemeData(
              primaryColor: const Color(0xFF007AFF),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF171717),
              appBarTheme: const AppBarTheme(
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  backgroundColor: Color(0xFF171717),
                  iconTheme: IconThemeData(color: Color(0xFF007AFF)),
                  actionsIconTheme: IconThemeData(color: Color(0xFF007AFF)),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light)),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 0.0,
                backgroundColor: Color(0xFF171717),
                selectedItemColor: Color(0xFF007AFF),
              ),
              inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: const Color(0xFF000000),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0))),
              buttonTheme:
                  const ButtonThemeData(buttonColor: Color(0xFF007AFF)),
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Color(0xFF171717)),
              dialogTheme: DialogTheme(
                  backgroundColor: const Color(0xFF171717),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16.0),
                      elevation: 0.0,
                      backgroundColor: const Color(0xFF007AFF))),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16.0),
                      foregroundColor: const Color(0xFF007AFF))),
            ),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        });
  }
}
