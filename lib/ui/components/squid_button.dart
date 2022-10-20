import 'package:flutter/material.dart';

class SquidButton extends StatelessWidget {
  final void Function() _handlePressed;
  final Widget? _icon;
  final String? _text;
  final double _width;
  final double _height;
  final BorderRadius _borderRadius;
  final double? _fontSize;

  const SquidButton({
    super.key,
    required void Function() handlePressed,
    Widget? icon,
    String? text,
    double width = double.infinity,
    double height = 48,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    double fontSize = 16,
  })  : _handlePressed = handlePressed,
        _icon = icon,
        _text = text,
        _width = width,
        _height = height,
        _borderRadius = borderRadius,
        _fontSize = fontSize;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (_icon != null) {
      children.add(
        Align(alignment: Alignment.centerLeft, child: _icon!),
      );
    }

    if (_text != null) {
      children.add(
        Align(
          alignment: Alignment.center,
          child: Text(
            _text!,
            style: TextStyle(fontSize: _fontSize),
          ),
        ),
      );
    }

    return SizedBox(
      width: _width,
      height: _height,
      child: ElevatedButton(
        onPressed: _handlePressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          padding: const EdgeInsets.all(8),
        ),
        child: Stack(children: children),
      ),
    );
  }
}

class SquidCircleButton extends StatelessWidget {
  final void Function() _onPressed;
  final Icon _icon;
  final double _size;
  final double _iconSize;

  const SquidCircleButton({
    super.key,
    required void Function() onPressed,
    required Icon icon,
    double size = 42,
    double iconSize = 32,
  })  : _onPressed = onPressed,
        _icon = icon,
        _size = size,
        _iconSize = iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      width: _size,
      child: FittedBox(
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: IconButton(
            onPressed: _onPressed,
            color: Theme.of(context).primaryColor,
            icon: _icon,
            iconSize: _iconSize,
          ),
        ),
      ),
    );
  }
}
