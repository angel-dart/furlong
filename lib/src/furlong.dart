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
      {List<Migration> migrations,
      String this.migrationTableName: "migrations"}) {
    if (migrations != null) this.migrations.addAll(migrations);
  }

  Future createMigrationTable() async {
    await connectionPool.query(
        "CREATE TABLE `$migrationTableName` (id integer not null auto_increment, name VARCHAR(255), batch INT(5), PRIMARY KEY(id))");
  }

  Future<bool> migrationTableExists() async {
    var result =
        await connectionPool.query("SHOW TABLES LIKE '$migrationTableName'");
    var list = await result.toList();
    return list.isNotEmpty;
  }

  Migrator createMigrator() => new MySqlMigrator();

  Future<int> getLastBatchNumber() async {
    var results = await connectionPool
        .query("SELECT max(batch) as batch from `$migrationTableName`");
    var row = await results.first;

    if (row == null || row[0] == null)
      return 0;
    else
      return row[0];
  }

  _batch(callback(Migrator migrator, Migration migration),
      [constraint(Migration migration)]) async {
    if (!await migrationTableExists()) await createMigrationTable();

    var migrator = createMigrator();

    for (Migration migration in migrations) {
      if (constraint != null) {
        if (await constraint(migration)) {
          await callback(migrator, migration);
        }
      } else {
        await callback(migrator, migration);
      }
    }

    await executeMigrator(migrator);
  }

  Future createMigrationRecords(String name, int batch) async {
    var query = await connectionPool.prepare(
        "INSERT INTO `$migrationTableName` (name, batch) VALUES(?, ?)");
    await query.execute([name, batch]);
  }

  Future deleteMigrationRecords(String name) => connectionPool
      .query("DELETE FROM `$migrationTableName` WHERE name = 'name'");

  Future deleteMigrationRecordsForBatch(int batch) => connectionPool
      .query("DELETE FROM `$migrationTableName` WHERE batch = $batch");

  Future deleteMigrationTable() =>
      connectionPool.query("DROP TABLE `$migrationTableName`");

  Future executeMigrator(Migrator migrator) async {
    var queries = migrator.queries.map((x) => x.toSql()).toList();
    queries.addAll(migrator.dropped.map((table) => "DROP TABLE `$table`"));

    var runner = new QueryRunner(connectionPool, queries);
    return await runner.executeQueries();
  }

  Future down() async {
    await _batch((migrator, migration) async {
      migration.destroy(migrator);
      await deleteMigrationRecords(migration.name);
    });
  }

  Future<List<String>> getMigrationsFromBatch(int batch) async {
    var results = await connectionPool
        .query("SELECT name from `$migrationTableName` WHERE batch = $batch");
    var list = await results.toList();
    return list.map((row) => row[0]).toList();
  }

  Future<bool> migrationHasNotBeenAlreadyRun(Migration migration) async {
    var results = await connectionPool.query(
        "SELECT * FROM `$migrationTableName` WHERE name = '${migration.name}'");
    var list = await results.toList();
    return list.isEmpty;
  }

  Future up() async {
    var batch = await getLastBatchNumber() + 1;

    await _batch((migrator, migration) async {
      await migration.create(migrator);
      await createMigrationRecords(migration.name, batch);
    }, migrationHasNotBeenAlreadyRun);
  }

  Future reset() async {
    print("Resetting database...");
    if (await migrationTableExists()) await deleteMigrationTable();

    print("Undoing all migrations...");
    await down();

    print("Running all outstanding migrations...");
    await up();
  }

  Future revert() async {
    if (!await migrationTableExists()) await createMigrationTable();

    var lastBatch = await getLastBatchNumber();
    var migrator = createMigrator();

    if (lastBatch < 1) throw new Exception("No migrations have been run yet.");

    var toRevert = await getMigrationsFromBatch(lastBatch);

    for (Migration migration in migrations) {
      if (toRevert.contains(migration.name)) {
        print("Reverting ${migration.name}...");
        await migration.destroy(migrator);
        await deleteMigrationRecords(migration.name);
      }
    }

    await executeMigrator(migrator);
    await deleteMigrationRecordsForBatch(lastBatch);
  }
}
