import 'package:flutter/material.dart';

showToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color(0xFF007AFF),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      content: Text(
        msg,
        style: const TextStyle(fontSize: 16.0, color: Colors.white),
      )));
}
