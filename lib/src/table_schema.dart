import 'generator.dart';

abstract class TableSchema {
  String get name;
  FieldGenerator primaryKey = null;
  FieldGenerator bigInteger(String name);
  FieldGenerator blob(String name);
  FieldGenerator boolean(String name);
  FieldGenerator char(String name);
  FieldGenerator date(String name);
  FieldGenerator dateTime(String name, {bool timeZone});
  FieldGenerator integer(String name, {bool autoIncrement, int defaultValue, int size});
  FieldGenerator json(String name);
  FieldGenerator jsonb(String name);
  FieldGenerator longText(String name);
  FieldGenerator mediumInteger(String name);
  FieldGenerator mediumText(String name);
  FieldGenerator smallInteger(String name);
  FieldGenerator text(String text);
  FieldGenerator time(String name, {bool timeZone});
  FieldGenerator timeStamp(String name, {bool nullable, bool timeZone});
  FieldGenerator tinyInteger(String name);
  FieldGenerator varChar(String name, {int size});
  String toSql();
}
