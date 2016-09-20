part of furlong.gen.mysql;

class MySqlTableSchema implements TableSchema {
  List<FieldGenerator> _generators = [];
  String _name;
  FieldGenerator _primaryKey = null;
  @override
  String get name => _name;
  FieldGenerator get primaryKey => _primaryKey;

  @override
  void set primaryKey(FieldGenerator field) {
    if (primaryKey != null)
      throw new RangeError("Table '$name' cannot have multiple primary keys.");
    else {
      _primaryKey = field;
    }
  }

  MySqlTableSchema._(this._name);

  _add(_FieldGenerator field) {
    _generators.add(field);
    return field;
  }

  @override
  String toSql() {
    var fields = _generators.map((x) => x.toSql()).toList();

    if (_primaryKey != null) fields.add("PRIMARY KEY(`${_primaryKey.name}`)");

    return "CREATE TABLE `$name` (${fields.join(', ')})";
  }

  _Int integer(String name,
      {bool autoIncrement: false, int defaultValue: null, int size: 4}) {
    return _add(new _Int(name, autoIncrement: autoIncrement, size: size));
  }

  _BigInt bigInteger(String name,
      {bool autoIncrement: false, num defaultValue: null, int size: 4}) {
    return _add(new _BigInt(name, autoIncrement: autoIncrement, size: size));
  }

  FieldGenerator blob(String name) =>
      _add(new _FieldGenerator(name, "BLOB", null));

  _Boolean boolean(String name) => _add(new _Boolean(name));

  FieldGenerator char(String name, {int size: 255}) =>
      _add(new _Char(name, size: size));

  _Date date(String name) => _add(new _Date(name));

  _DateTime dateTime(String name) => _add(new _DateTime(name));

  _Enumerator enumerator(String name, List<String> potentialValues) => _add(new _Enumerator(name, potentialValues));

  FieldGenerator id([String idField]) =>
      primaryKey = integer(idField ?? "id", autoIncrement: true);

  _FieldGenerator json(String name) => _add(new _FieldGenerator(name, "JSON", null));

  _LongText longText(String name) => _add(new _LongText(name));

  _MediumInt mediumInteger(String name,
      {bool autoIncrement: false, int defaultValue: null, int size: 3}) {
    return _add(new _MediumInt(name, autoIncrement: autoIncrement, size: size));
  }

  _MediumText mediumText(String name) => _add(new _MediumText(name));

  _SmallInt smallInteger(String name,
      {bool autoIncrement: false, int defaultValue: null, int size: 2}) {
    return _add(new _SmallInt(name, autoIncrement: autoIncrement, size: size));
  }

  _String string(String name, {int size: 255}) {
    return _add(new _String(name, size: size));
  }

  _Text text(String name) => _add(new _Text(name));

  _Time time(String name) => _add(new _Time(name));

  _TimeStamp timeStamp(String name) => _add(new _TimeStamp(name));

  _TinyInt tinyInteger(String name,
      {bool autoIncrement: false, int defaultValue: null, int size: 1}) {
    return _add(new _TinyInt(name, autoIncrement: autoIncrement, size: size));
  }

  _TinyText tinyText(String name) => _add(new _TinyText(name));
}
