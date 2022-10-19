import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

String _getHexString(int val) => val.toRadixString(16).padLeft(2, '0');
Color _getColor(String val) => Color(int.parse(val, radix: 16));

extension HexColor on Color {
  String hex() => '${_getHexString(alpha)}${_getHexString(red)}${_getHexString(green)}${_getHexString(blue)}';
}

@immutable
class Note extends Equatable {
  final String id;
  final String title;
  final Color color;
  final Color textColor;

  const Note({required this.id, required this.title, required this.color, required this.textColor});

  Note.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          color: _getColor(json['color'] as String),
          textColor: _getColor(json['textColor'] as String),
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color.hex(),
      'textColor': textColor.hex(),
    };
  }

  static Map<String, dynamic> frame({String? title, Color? color, Color? textColor}) {
    return {
      if (title != null) 'title': title,
      if (color != null) 'color': color.hex(),
      if (textColor != null) 'textColor': textColor.hex(),
    };
  }

  @override
  List<Object?> get props => [id];
}
