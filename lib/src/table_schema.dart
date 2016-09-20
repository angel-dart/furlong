import 'generator.dart';

abstract class TableSchema {
  String get name;
  FieldGenerator primaryKey = null;
  FieldGenerator bigInteger(String name, {bool autoIncrement, int size});
  FieldGenerator blob(String name);
  FieldGenerator boolean(String name);
  FieldGenerator char(String name, {int size});
  FieldGenerator date(String name);
  FieldGenerator dateTime(String name);
  FieldGenerator enumerator(String name, List<String> potentialValues);
  FieldGenerator id([String idField]);
  FieldGenerator integer(String name, {bool autoIncrement, int size});
  FieldGenerator json(String name);
  FieldGenerator longText(String name);
  FieldGenerator mediumInteger(String name, {bool autoIncrement, int size});
  FieldGenerator mediumText(String name);
  // Todo: Reference other table
  FieldGenerator smallInteger(String name);
  FieldGenerator string(String name, {int size});
  FieldGenerator text(String name);
  FieldGenerator time(String name);
  FieldGenerator timeStamp(String name);
  FieldGenerator tinyInteger(String name, {bool autoIncrement, int size});
  FieldGenerator tinyText(String name);
  String toSql();
}
