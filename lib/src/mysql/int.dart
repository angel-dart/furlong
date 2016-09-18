part of furlong.gen.mysql;

class _Int extends _FieldGenerator {
  bool autoIncrement;
  int _defaultValue = null;

  @override
  String get defaultValue => _defaultValue.toString();

  void set defaultValue(value) {
    if (value is! int)
      throw new ArgumentError("'$value' is not an INT.");
    _defaultValue = value;
  }

  _Int(String name, {this.autoIncrement: false, int defaultValue: null, size})
      : super(name, "INT", size ?? 4) {
    if (defaultValue != null)
      _defaultValue = defaultValue;
    if (autoIncrement)
      nullable = false;
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
