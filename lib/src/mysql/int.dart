part of furlong.gen.mysql;

class _Int extends _FieldGenerator {
  bool autoIncrement;
  int _defaultValue = null;

  @override
  String get defaultValue => _defaultValue.toString();

  void set defaultValue(value) {
    if (value is! int) throw new ArgumentError("'$value' is not an INT.");
    _defaultValue = value;
  }

  _Int(String name, {this.autoIncrement: false, size, String type})
      : super(name, type ?? "INT", size ?? 4) {
    if (autoIncrement) nullable = false;
  }

  @override
  String toSql() {
    if (autoIncrement) {
      nullable = false;
      return "${super.toSql()} auto_increment";
    } else
      return super.toSql();
  }
}

class _MediumInt extends _Int {
  int _defaultValue = null;

  @override
  String get defaultValue => _defaultValue.toString();

  void set defaultValue(value) {
    if (value is! int) throw new ArgumentError("'$value' is not a MEDIUMINT.");
    _defaultValue = value;
  }

  _MediumInt(String name, {bool autoIncrement: false, size})
      : super(name,
            autoIncrement: autoIncrement, size: size ?? 3, type: "MEDIUMINT");
}

class _TinyInt extends _Int {
  int _defaultValue = null;

  @override
  String get defaultValue => _defaultValue.toString();

  void set defaultValue(value) {
    if (value is! int) throw new ArgumentError("'$value' is not a TINYINT.");
    _defaultValue = value;
  }

  _TinyInt(String name, {bool autoIncrement: false, size})
      : super(name,
            autoIncrement: autoIncrement, size: size ?? 1, type: "TINYINT");
}

class _SmallInt extends _Int {
  int _defaultValue = null;

  @override
  String get defaultValue => _defaultValue.toString();

  void set defaultValue(value) {
    if (value is! int) throw new ArgumentError("'$value' is not a SMALLINT.");
    _defaultValue = value;
  }

  _SmallInt(String name, {bool autoIncrement: false, size})
      : super(name,
            autoIncrement: autoIncrement, size: size ?? 2, type: "SMALLINT");
}

class _BigInt extends _Int {
  num _defaultValue = null;

  @override
  String get defaultValue => _defaultValue.toString();

  void set defaultValue(value) {
    if (value is! num) throw new ArgumentError("'$value' is not a BIGINT.");
    _defaultValue = value;
  }

  _BigInt(String name, {bool autoIncrement: false, size})
      : super(name,
            autoIncrement: autoIncrement, size: size ?? 8, type: "BIGINT");
}

class _Boolean extends _TinyInt {
  bool __defaultValue = null;

  @override
  void set defaultValue(value) {
    __defaultValue = value;
  }

  @override
  String get defaultValue {
    if (__defaultValue != null)
      return __defaultValue ? "TRUE" : "FALSE";
    else return null;
  }

  _Boolean(String name):super(name, size: 1);
}