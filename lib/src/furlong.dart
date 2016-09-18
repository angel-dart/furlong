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

  Future checkForMigrationsTable() async {
    var results = await connectionPool.query("");
    
  }

  Future down() async {}

  Future reset() async {
    await down();
    await up();
  }

  Future revert() async {}

  Future up() async {}
}
