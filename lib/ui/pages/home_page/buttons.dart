import 'package:flutter/material.dart';

Widget getAddButton(BuildContext context, void Function() onAdd) {
  Color foreground = Theme.of(context).primaryColor;

  return Positioned(
    left: 16,
    bottom: 16,
    child: FloatingActionButton(
      heroTag: "AddButton",
      onPressed: onAdd,
      elevation: 0,
      foregroundColor: foreground,
      backgroundColor: Colors.transparent,
      child: const Icon(Icons.add),
    ),
  );
}

Widget getSettingsButton(BuildContext context, void Function() onSettings) {
  Color foreground = Theme.of(context).primaryColor;

  return Positioned(
    right: 16,
    bottom: 16,
    child: FloatingActionButton(
      heroTag: "SettingsButton",
      onPressed: onSettings,
      elevation: 0,
      foregroundColor: foreground,
      backgroundColor: Colors.transparent,
      child: const Icon(Icons.settings_outlined),
    ),
  );
}
