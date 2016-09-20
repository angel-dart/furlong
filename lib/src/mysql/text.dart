part of furlong.gen.mysql;

class _Text extends _FieldGenerator {
  String _defaultValue;

  @override
  void set defaultValue(String value) {
    _defaultValue = value;
  }

  @override String get defaultValue => "'$_defaultValue'";

  _Text(String name, {String type}) : super(name, type ?? "TEXT", null);
}

class _TinyText extends _Text {
  _TinyText(String name) : super(name, type: "TINYTEXT");
}

class _MediumText extends _Text {
  _MediumText(String name) : super(name, type: "MEDIUMTEXT");
}

class _LongText extends _Text {
  _LongText(String name) : super(name, type: "LONGTEXT");
}
