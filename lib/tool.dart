import 'dart:async';
import 'package:furlong/furlong.dart';
import 'package:sqljocky/sqljocky.dart';

class FurlongTool {
  Furlong _furlong;
  ConnectionPool connectionPool;
  List<Migration> migrations;

  FurlongTool(this.connectionPool, {List<Migration> migrations}) {
    if (migrations != null) this.migrations.addAll(migrations);
    _furlong = new Furlong(connectionPool, migrations: migrations);
  }

  Future migrateDown(List<Migration> migrations) => _furlong.down();

  Future migrateReset(List<Migration> migrations) => _furlong.reset();

  Future migrateRevert(List<Migration> migrations) => _furlong.revert();

  Future migrateUp(List<Migration> migrations) => _furlong.up();
}
