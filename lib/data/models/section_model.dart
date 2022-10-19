import 'package:flutter/foundation.dart';

enum SectionType {
  header,
  paragraph,
  checklist,
}

@immutable
abstract class Section {
  final int index;
  final SectionType type;

  const Section({required this.index, required this.type});

  factory Section.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'SectionType.header':
        return HeaderSection.fromJson(json);
      case 'SectionType.paragraph':
        return ParagraphSection.fromJson(json);
      case 'SectionType.checklist':
        return ChecklistSection.fromJson(json);
      default:
        throw ArgumentError('Section factory received JSON with an invalid type: ${json['type']}');
    }
  }

  Map<String, dynamic> toJson();
}

@immutable
class HeaderSection extends Section {
  final String headerText;

  const HeaderSection({
    required int index,
    required this.headerText,
  }) : super(index: index, type: SectionType.header);

  const HeaderSection.createAt({required int index}) : this(index: index, headerText: '');

  HeaderSection.fromJson(Map<String, dynamic> json)
      : this(
          index: json['index'] as int,
          headerText: json['headerText'] as String,
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'type': describeEnum(type),
      'headerText': headerText,
    };
  }
}

@immutable
class ParagraphSection extends Section {
  final String paragraphText;

  const ParagraphSection({
    required int index,
    required this.paragraphText,
  }) : super(index: index, type: SectionType.paragraph);

  const ParagraphSection.createAt({required int index}) : this(index: index, paragraphText: '');

  ParagraphSection.fromJson(Map<String, dynamic> json)
      : this(
          index: json['index'] as int,
          paragraphText: json['paragraphText'] as String,
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'type': describeEnum(type),
      'paragraphText': paragraphText,
    };
  }
}

@immutable
class ChecklistSection extends Section {
  final List<bool> isChecked;
  final List<String> text;

  ChecklistSection({
    required int index,
    required this.isChecked,
    required this.text,
  }) : super(index: index, type: SectionType.paragraph) {
    if (isChecked.length != text.length) {
      throw ArgumentError('Checklist section received isChecked and text lists with mismatched lengths.');
    }
  }

  ChecklistSection.createAt({required int index}) : this(index: index, isChecked: [false], text: ['']);

  ChecklistSection.fromJson(Map<String, dynamic> json)
      : this(
          index: json['index'] as int,
          isChecked: json['isChecked'] as List<bool>,
          text: json['text'] as List<String>,
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'type': describeEnum(type),
      'isChecked': isChecked,
      'text': text,
    };
  }
}
