import 'package:flutter/material.dart';

class SquidTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final IconButton? suffixIcon;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final double? fontSize;

  const SquidTextField({
    super.key,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.all(12),
    this.hintText,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: borderRadius),
        contentPadding: padding,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
