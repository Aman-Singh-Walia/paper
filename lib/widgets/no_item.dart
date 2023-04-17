import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  final String msg;
  const NoItem({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).disabledColor),
      ),
    );
  }
}
