import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
 static late SharedPreferences prefs;

 static init() async{
    prefs = await SharedPreferences.getInstance();
  }
}
