 import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final bool? destructive;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    this.destructive,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: [
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          textColor: destructive == true
              ? const Color(0xFFFF3B30)
              : const Color(0xFF007AFF),
          dense: true,
          title: Text(
            confirmText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
          onTap: () => Navigator.pop(context, true),
        ),
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          textColor: const Color(0xFF007AFF),
          dense: true,
          title: Text(
            cancelText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
          onTap: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}


