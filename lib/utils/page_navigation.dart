import 'package:flutter/material.dart';

goToPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

replacePage(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

goBack(BuildContext context) {
  Navigator.pop(context);
}
