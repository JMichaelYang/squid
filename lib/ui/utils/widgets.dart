import 'package:flutter/material.dart';

class SquidButton extends StatelessWidget {
  final void Function() _handlePressed;
  final Widget? _icon;
  final String? _text;
  final double _width;
  final double _height;
  final BorderRadius _borderRadius;

  const SquidButton({
    super.key,
    required void Function() handlePressed,
    Widget? icon,
    String? text,
    double width = double.infinity,
    double height = 48,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
  })  : _handlePressed = handlePressed,
        _icon = icon,
        _text = text,
        _width = width,
        _height = height,
        _borderRadius = borderRadius;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (_icon != null) children.add(Align(alignment: Alignment.centerLeft, child: _icon!));
    if (_text != null) children.add(Align(alignment: Alignment.center, child: Text(_text!)));

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

class SquidTextField extends StatelessWidget {
  final TextEditingController? _controller;
  final bool _obscureText;
  final IconButton? _suffixIcon;
  final BorderRadius _borderRadius;
  final EdgeInsetsGeometry? _padding;
  final String? _hintText;

  const SquidTextField({
    super.key,
    TextEditingController? controller,
    bool obscureText = false,
    IconButton? suffixIcon,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    EdgeInsetsGeometry? padding = const EdgeInsets.all(12),
    String? hintText,
  })  : _controller = controller,
        _obscureText = obscureText,
        _suffixIcon = suffixIcon,
        _borderRadius = borderRadius,
        _padding = padding,
        _hintText = hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: _borderRadius),
        contentPadding: _padding,
        hintText: _hintText,
        suffixIcon: _suffixIcon,
      ),
    );
  }
}
