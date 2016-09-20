import 'package:test/test.dart';
import 'format_test.dart' as formats;
import 'mysql/all_tests.dart' as mysql;

main() {
  group("formats", formats.main);
  group("mysql", mysql.main);
}