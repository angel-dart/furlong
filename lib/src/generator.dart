abstract class FieldGenerator {
  var defaultValue;
  String get name;
  bool nullable;
  String toSql();
}
