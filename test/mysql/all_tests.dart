import 'package:sqljocky/sqljocky.dart';
import 'package:test/test.dart';
import 'create_pool.dart';
import 'codegen.dart' as codegen;

main() async {
  var pool = await createPool();

  group("codegen", codegen.runTests(pool));
}