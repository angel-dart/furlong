import 'package:furlong/furlong.dart';
import 'package:sqljocky/sqljocky.dart';
import 'common.dart';

main() async {
  var furlong =
      new Furlong(new ConnectionPool(), migrations: [new TodoMigration()]);
  await furlong.up();
}