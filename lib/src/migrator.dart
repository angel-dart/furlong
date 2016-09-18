import 'dart:async';
import 'table_schema.dart';

abstract class Migrator {
  Future create(String name, callback(TableSchema table));
  Future drop(List<String> names);
}

