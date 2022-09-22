class SquidError implements Exception {
  final String _namespace;
  String get namespace => _namespace;

  final String _errorCode;
  String get errorCode => _errorCode;

  SquidError({required String namespace, required String errorCode})
      : _namespace = namespace,
        _errorCode = errorCode;

  SquidError.unknown({required String message})
      : _namespace = 'unknown',
        _errorCode = message;

  bool isEqual({required String namespace, required String errorCode}) {
    return this.namespace == namespace && this.errorCode == errorCode;
  }

  @override
  bool operator ==(Object other) =>
      other is SquidError && _namespace == other._namespace && _errorCode == other._errorCode;

  @override
  int get hashCode => Object.hash(_namespace, _errorCode);
}
