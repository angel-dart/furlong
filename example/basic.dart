import 'dart:async';
import 'package:furlong/furlong.dart';
import 'package:sqljocky/sqljocky.dart';

main() async {
  var furlong =
      new Furlong(new ConnectionPool(), migrations: [new TodoMigration()]);
  await furlong.up();
}

class TodoMigration extends Migration {
  @override
  String get name => "Todo table";

  @override
  Future create(Migrator migrator) async {
    await migrator.create("todos", (TableSchema table) {
      table.primaryKey = table.integer("id", autoIncrement: true);

      table.varChar("title")..nullable = true;
      table.varChar("text");
      table.timeStamp("created_at");
      table.timeStamp("updated_at");
    });
  }

  @override
  Future destroy(Migrator migrator) async {
    await migrator.drop(["todos"]);
  }
}
