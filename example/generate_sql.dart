import 'package:furlong/build.dart';
import 'common.dart';

main() async {
  print(await createMigrationToSql(new TodoMigration()));
}
