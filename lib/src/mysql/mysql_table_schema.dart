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
    return _add(new _Int(name,
        autoIncrement: autoIncrement, defaultValue: defaultValue, size: size));
  }

  FieldGenerator bigInteger(String name) {}

  FieldGenerator blob(String name) {}

  FieldGenerator boolean(String name) {}

  FieldGenerator char(String name) {}

  FieldGenerator date(String name) {}

  FieldGenerator dateTime(String name, {bool timeZone}) {}

  FieldGenerator id([String idField]) =>
      primaryKey = integer(idField ?? "id", autoIncrement: true);

  FieldGenerator json(String name) {}

  FieldGenerator jsonb(String name) {}

  FieldGenerator longText(String name) {}

  FieldGenerator mediumInteger(String name) {}

  FieldGenerator mediumText(String name) {}

  FieldGenerator smallInteger(String name) {}

  FieldGenerator text(String text) {}

  FieldGenerator time(String name, {bool timeZone}) {}

  FieldGenerator timeStamp(String name, {bool nullable, bool timeZone}) {}

  FieldGenerator tinyInteger(String name) {}

  _VarChar varChar(String name, {int size: 255}) {
    return _add(new _VarChar(name, size: size));
  }
}
