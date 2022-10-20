import 'package:flutter/material.dart';

Widget getAddButton(void Function() onAdd) {
  return Positioned(
    left: 8,
    bottom: 8,
    child: _CircleButton(
      icon: const Icon(Icons.add),
      onPressed: onAdd,
    ),
  );
}

Widget getSettingsButton(void Function() onSettings) {
  return Positioned(
    right: 8,
    bottom: 8,
    child: _CircleButton(
      icon: const Icon(Icons.settings_outlined),
      onPressed: onSettings,
    ),
  );
}

class _CircleButton extends StatelessWidget {
  final void Function() _onPressed;
  final Icon _icon;

  const _CircleButton({required void Function() onPressed, required Icon icon})
      : _onPressed = onPressed,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: FittedBox(
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: IconButton(
            onPressed: _onPressed,
            color: Theme.of(context).primaryColor,
            icon: _icon,
            iconSize: 32,
          ),
        ),
      ),
    );
  }
}
