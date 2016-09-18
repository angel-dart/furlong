import 'table_schema.dart';

abstract class Migrator {
  List<TableSchema> get schemas;
  String get type;
  create(String name, callback(TableSchema table));
  drop(List<String> names);
}

