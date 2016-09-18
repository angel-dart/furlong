library furlong.gen.mysql;

import 'dart:async';
import '../generator.dart';
import '../migrator.dart';
import '../table_schema.dart';

part 'int.dart';
part 'mysql_table_schema.dart';
part 'varchar.dart';

class MySqlMigrator extends Migrator {
  List<TableSchema> _schemas = [];

  @override
  List<TableSchema> get schemas => new List.from(_schemas, growable: false);

  @override
  String get type => "mysql";

  @override
  drop(List<String> names) async => [];

  @override
  create(String name, callback(TableSchema table)) {
    var schema = new MySqlTableSchema._(name);
    var result = callback(schema);

    if (result is Future) {
      return result.then((_) {
        _schemas.add(schema);
      });
    } else {
      _schemas.add(schema);
    }
  }
}

class _FieldGenerator extends FieldGenerator {
  String defaultValue = null;
  String name;
  bool nullable = false;
  int size;
  String type;

  _FieldGenerator(String this.name, this.type, this.size);

  @override
  String toSql() {
    String result = "`$name` $type($size)";

    if (!nullable) result += " not null";

    if (defaultValue != null && defaultValue.toString() != "null")
      result += " DEFAULT $defaultValue";

    return result;
  }
}
