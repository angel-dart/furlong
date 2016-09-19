import 'table_schema.dart';

abstract class Migrator {
  List<String> get dropped;
  List<TableSchema> get queries;
  String get type;
  create(String name, callback(TableSchema table));
  drop(List<String> names);
}

