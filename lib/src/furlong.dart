import 'dart:async';
import 'package:sqljocky/sqljocky.dart';
import 'migration.dart';

class Furlong {
  ConnectionPool connectionPool;
  List<Migration> migrations = [];
  String migrationTableName;

  Furlong(this.connectionPool,
      {List<Migration> migrations, String this.migrationTableName: "furlong"}) {
    if (migrations != null) this.migrations.addAll(migrations);
  }

  Future createMigrationTable() async {
    await connectionPool.query("CREATE TABLE '$migrationTableName' (id integer not null auto_increment name VARCHAR(255), batch INT(5))");
  }

  Future<bool> migrationTableExists() {
    return connectionPool.query("SHOW TABLES LIKE '$migrationTableName'").then((results) {
      return results.toList().then((rows) {
        return rows.isNotEmpty;
      });
    });
   }

  Future down() async {
    if (!await migrationTableExists())
      await createMigrationTable();
  }

  Future reset() async {
    await down();
    await up();
  }

  Future revert() async {}

  Future up() async {
    if (!await migrationTableExists())
      await createMigrationTable();

    for (Migration migration in migrations) {

    }
  }
}
