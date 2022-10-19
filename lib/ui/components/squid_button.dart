import 'package:flutter/material.dart';

class SquidButton extends StatelessWidget {
  final void Function() handlePressed;
  final Widget? icon;
  final String? text;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final double? fontSize;

  const SquidButton({
    super.key,
    required this.handlePressed,
    this.icon,
    this.text,
    this.width = double.infinity,
    this.height = 48,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (icon != null) {
      children.add(
        Align(alignment: Alignment.centerLeft, child: icon!),
      );
    }

    if (text != null) {
      children.add(
        Align(
          alignment: Alignment.center,
          child: Text(
            text!,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: handlePressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: const EdgeInsets.all(8),
        ),
        child: Stack(children: children),
      ),
    );
  }
}