part of furlong.gen.mysql;

class _Date extends _FieldGenerator {
  var _defaultValue = null;
  static final DateFormat _format = new DateFormat("y-MM-dd");

  @override
  get defaultValue {
    if (_defaultValue != null && _defaultValue is DateTime)
      return "'${_format.format(_defaultValue)}'";
    else if (_defaultValue != null && _defaultValue is String)
      return "'$_defaultValue'";

    return null;
  }

  set defaultValue(value) {
    _defaultValue = value;
  }

  _Date(String name) : super(name, "DATE", null);
}

class _Time extends _FieldGenerator {
  var _defaultValue = null;
  static final DateFormat _format = new DateFormat("H:m:s");

  @override
  get defaultValue {
    if (_defaultValue != null && _defaultValue is DateTime)
      return "'${_format.format(_defaultValue)}'";
    else if (_defaultValue != null && _defaultValue is String)
      return "'$_defaultValue'";

    return null;
  }

  set defaultValue(value) {
    _defaultValue = value;
  }

  _Time(String name) : super(name, "TIME", null);
}

class _DateTime extends _FieldGenerator {
  var _defaultValue = null;
  static final DateFormat _format = new DateFormat("y-MM-dd H:m:s");

  @override
  get defaultValue {
    if (_defaultValue != null && _defaultValue is DateTime)
      return "'${_format.format(_defaultValue)}'";
    else if (_defaultValue != null && _defaultValue is String)
      return "'$_defaultValue'";

    return null;
  }

  set defaultValue(value) {
    _defaultValue = value;
  }

  _DateTime(String name, {String type}) : super(name, type ?? "DATETIME", null);
}

class _TimeStamp extends _DateTime {
  _TimeStamp(String name):super(name, type: "TIMESTAMP");
}