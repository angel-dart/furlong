library furlong.gen.mysql;

import 'dart:async';
import '../generator.dart';
import '../migrator.dart';
import '../table_schema.dart';

part 'int.dart';
part 'mysql_table_schema.dart';
part 'varchar.dart';

class MySqlMigrator extends Migrator {
  List<String> _dropped = [];
  List<TableSchema> _queries = [];

  List<String> get dropped => new List.from(_dropped, growable: false);

  List<TableSchema> get queries => new List.from(_queries, growable: false);

  String get type => "mysql";

  drop(List<String> names) => _dropped.addAll(names);

  create(String name, callback(TableSchema table)) {
    var schema = new MySqlTableSchema._(name);
    var result = callback(schema);

    if (result is Future) {
      return result.then((_) {
        _queries.add(schema);
      });
    } else {
      _queries.add(schema);
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
