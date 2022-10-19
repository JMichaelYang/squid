import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Section.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? data = snapshot.data();

    switch (data?['type']) {
      case 'SectionType.header':
        return HeaderSection.fromFirestore(data);
      case 'SectionType.paragraph':
        return ParagraphSection.fromFirestore(data);
      case 'SectionType.checklist':
        return ChecklistSection.fromFirestore(data);
      default:
        throw ArgumentError('Section factory received JSON with an invalid type: ${data?['type']}');
    }
  }

  Map<String, dynamic> toFirestore();
}

@immutable
class HeaderSection extends Section {
  final String headerText;

  const HeaderSection({
    required int index,
    required this.headerText,
  }) : super(index: index, type: SectionType.header);

  HeaderSection.fromFirestore(Map<String, dynamic>? data)
      : this(
          index: data?['index'],
          headerText: data?['headerText'],
        );

  @override
  Map<String, dynamic> toFirestore() {
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

  ParagraphSection.fromFirestore(Map<String, dynamic>? data)
      : this(
          index: data?['index'],
          paragraphText: data?['paragraphText'],
        );

  @override
  Map<String, Object?> toFirestore() {
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

  ChecklistSection.fromFirestore(Map<String, dynamic>? data)
      : this(
          index: data?['index'],
          isChecked: data?['isChecked'] is Iterable ? List.from(data?['isChecked']) : [false],
          text: data?['text'] is Iterable ? List.from(data?['text']) : [''],
        );

  @override
  Map<String, Object?> toFirestore() {
    return {
      'index': index,
      'type': describeEnum(type),
      'isChecked': isChecked,
      'text': text,
    };
  }
}
