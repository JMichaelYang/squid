import 'package:flutter/material.dart';

Widget getAddButton(BuildContext context, void Function() onAdd) {
  return Positioned(
    left: 8,
    bottom: 8,
    child: SizedBox(
      height: 40,
      width: 40,
      child: FittedBox(
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: IconButton(
            onPressed: onAdd,
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.add),
            iconSize: 32,
          ),
        ),
      ),
    ),
  );
}

Widget getSettingsButton(BuildContext context, void Function() onSettings) {
  return Positioned(
    right: 8,
    bottom: 8,
    child: SizedBox(
      height: 40,
      width: 40,
      child: FittedBox(
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: IconButton(
            onPressed: onSettings,
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.settings_outlined),
            iconSize: 32,
          ),
        ),
      ),
    ),
  );
}
