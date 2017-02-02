import 'dart:async';
import 'package:furlong/furlong.dart';

class TodoMigration extends Migration {
  @override
  String get name => "Todo table";

  @override
  Future create(Migrator migrator) async {
    await migrator.create("todos", (TableSchema table) {
      table.primaryKey = table.integer("id", autoIncrement: true);

      table.string("title")..nullable = true;
      table.string("text");
      table.timeStamp("created_at");
      table.timeStamp("updated_at");
    });
  }

  @override
  Future destroy(Migrator migrator) async {
    await migrator.drop(["todos"]);
  }
}
