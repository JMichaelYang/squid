import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class SquidError extends Equatable implements Exception {
  final String namespace;
  final String errorCode;
  final String? message;

  const SquidError({required this.namespace, required this.errorCode}) : message = null;

  const SquidError.unknown({required String code, this.message})
      : namespace = 'unknown',
        errorCode = 'unknown-$code-error';

  bool isEqual({required String namespace, required String? errorCode, String? message}) {
    return this.namespace == namespace && this.errorCode == errorCode && this.message == message;
  }

  @override
  List<Object?> get props => [namespace, errorCode, message];
}
