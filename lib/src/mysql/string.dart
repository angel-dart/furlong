part of furlong.gen.mysql;

class _String extends _FieldGenerator {
  String _defaultValue = null;

  @override
  String get defaultValue {
    if (_defaultValue != null)
      return "'$_defaultValue'";
    else return null;
  }

  void set defaultValue(value) {
    if (value is! String) throw new ArgumentError("'$value' is not a VARCHAR.");
    _defaultValue = value;
  }

  _String(String name, {int size}) : super(name, "VARCHAR", size ?? 255);
}

class _Char extends _FieldGenerator {
  String _defaultValue = null;

  @override
  String get defaultValue {
    if (_defaultValue != null)
      return "'$_defaultValue'";
    else return null;
  }

  void set defaultValue(value) {
    if (value is! String) throw new ArgumentError("'$value' is not a CHAR.");
    _defaultValue = value;
  }

  _Char(String name, {int size}) : super(name, "CHAR", size ?? 255);
}
