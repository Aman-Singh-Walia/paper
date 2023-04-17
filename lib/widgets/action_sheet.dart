import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showActionSheet(BuildContext context, List<ActionSheetItem> actions) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.0), bottom: Radius.zero)),
      context: context,
      builder: (context) => Wrap(
            alignment: WrapAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(3.0),
                        right: Radius.circular(3.0))),
                height: 5.0,
                width: 60.0,
              ),
              ...actions,
              ActionSheetItem(
                  title: "Close",
                  icon: const Icon(BootstrapIcons.x_lg),
                  onClick: () {
                    Navigator.pop(context);
                  })
            ],
          ));
}

class ActionSheetItem extends StatelessWidget {
  final String title;
  final Icon? icon;
  final bool? isDestructive;
  final Function onClick;
  const ActionSheetItem(
      {super.key,
      required this.title,
      required this.onClick,
      this.icon,
      this.isDestructive});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: isDestructive == true
          ? CupertinoColors.destructiveRed
          : Theme.of(context).primaryColor,
      iconColor: isDestructive == true
          ? CupertinoColors.destructiveRed
          : Theme.of(context).primaryColor,
      onTap: () {
        onClick();
      },
      leading: icon,
      title: Text(title),
    );
  }
}
