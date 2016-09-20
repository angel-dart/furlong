part of furlong.gen.mysql;

class _Enumerator extends _FieldGenerator {
  String _defaultValue = null;
  List<String> potentialValues;

  @override String get defaultValue => _defaultValue != null ? "'$_defaultValue'" : null;

  @override
  set defaultValue(String value) {
    if (!potentialValues.contains(value))
      throw new ArgumentError("Provided enum value must be " + potentialValues.map((x) => "'$x'").join(" or ") + ", not '$value'.");

    _defaultValue = value;
  }

  @override
  String get type {
    var values = potentialValues.map((x) => "'$x'");
    return "ENUM(${values.join(', ')})";
  }

  _Enumerator(String name, List<String> potentialValues):super(name, null, null) {
    if (potentialValues.isEmpty)
      throw new ArgumentError("Enum cannot contain empty set of possible values.");

    this.potentialValues = new List.from(potentialValues, growable: false);
  }
}
