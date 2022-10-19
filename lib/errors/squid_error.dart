import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ErrorNamespace {
  static const String auth = 'auth';
  static const String notes = 'notes';
  static const String sections = 'sections';
  static const String share = 'share';
}

@immutable
class SquidError extends Equatable implements Exception {
  final String namespace;
  final String errorCode;
  final String? message;

  const SquidError({required this.namespace, required this.errorCode, this.message});

  @override
  List<Object?> get props => [namespace, errorCode, message];
}
