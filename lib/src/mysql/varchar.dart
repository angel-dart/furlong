part of furlong.gen.mysql;

class _VarChar extends _FieldGenerator {
  String _defaultValue = null;

  @override
  String get defaultValue => _defaultValue;

  void set defaultValue(value) {
    if (value is! String) throw new ArgumentError("'$value' is not a VARCHAR.");
    _defaultValue = value;
  }

  _VarChar(String name, {int size}) : super(name, "VARCHAR", size ?? 255);
}
