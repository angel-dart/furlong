import 'dart:async';
import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';
import 'migration.dart';
import 'migrator.dart';
import 'mysql/mysql.dart';

class Furlong {
  ConnectionPool connectionPool;
  List<Migration> migrations = [];
  String migrationTableName;

  Furlong(this.connectionPool,
      {List<Migration> migrations, String this.migrationTableName: "furlong"}) {
    if (migrations != null) this.migrations.addAll(migrations);
  }

  Future createMigrationTable() async {
    await connectionPool.query("CREATE TABLE `$migrationTableName` (id integer not null auto_increment name VARCHAR(255), batch INT(5))");
  }

  Future<bool> migrationTableExists() {
    return connectionPool.query("SHOW TABLES LIKE `$migrationTableName`").then((results) {
      return results.toList().then((rows) {
        return rows.isNotEmpty;
      });
    });
   }

  Migrator createMigrator() => new MySqlMigrator();

  _batch(callback(Migrator migrator, Migration migration)) async {
    if (!await migrationTableExists())
      await createMigrationTable();

    var migrator = createMigrator();

    for (Migration migration in migrations) {
      await callback(migrator, migration);
    }

    var runner = new QueryRunner(connectionPool, migrator.schemas.map((x) => x.toSql()).toList());
    return await runner.executeQueries();
  }

  Future down() => _batch((migrator, migration) => migration.destroy(migrator));
  Future up() => _batch((migrator, migration) => migration.destroy(migrator));

  Future reset() async {
    await down();
    await up();
  }

  Future revert() async {}
}
