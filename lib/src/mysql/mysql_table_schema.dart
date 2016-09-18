part of furlong.gen.mysql;

class MySqlTableSchema implements TableSchema {
  List<FieldGenerator> _generators = [];
  String _name;
  FieldGenerator _primaryKey = null;
  @override String get name => _name;
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

    if (_primaryKey != null)
      fields.add("PRIMARY KEY(`${_primaryKey.name}`)");

    return "CREATE TABLE `$name` (${fields.join(', ')})";
  }

  @override
  _Int integer(String name, {bool autoIncrement: false, int defaultValue: null, int size: 4}) {
    return _add(new _Int(name, autoIncrement: autoIncrement, defaultValue: defaultValue, size: size));
  }


  @override
  FieldGenerator bigInteger(String name) {

  }

  @override
  FieldGenerator blob(String name) {

  }

  @override
  FieldGenerator boolean(String name) {

  }

  @override
  FieldGenerator char(String name) {

  }

  @override
  FieldGenerator date(String name) {

  }

  @override
  FieldGenerator dateTime(String name, {bool timeZone}) {

  }

  @override
  FieldGenerator json(String name) {

  }

  @override
  FieldGenerator jsonb(String name) {

  }

  @override
  FieldGenerator longText(String name) {

  }

  @override
  FieldGenerator mediumInteger(String name) {

  }

  @override
  FieldGenerator mediumText(String name) {

  }

  @override
  FieldGenerator smallInteger(String name) {

  }

  @override
  FieldGenerator text(String text) {

  }

  @override
  FieldGenerator time(String name, {bool timeZone}) {

  }

  @override
  FieldGenerator timeStamp(String name, {bool nullable, bool timeZone}) {

  }

  @override
  FieldGenerator tinyInteger(String name) {

  }

  @override
  _VarChar varChar(String name, {int size: 255}) {
    return _add(new _VarChar(name, size: size));
  }
}
