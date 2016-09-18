abstract class FieldGenerator {
  String defaultValue;
  String get name;
  bool nullable;
  String toSql();
}
