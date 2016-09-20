import 'package:intl/intl.dart';
import 'package:test/test.dart';

main() {
  final now = new DateTime.now();
  final formats = <String> [
    "y-MM-dd",
    "y-MM-dd H:m:s"
  ];

  /*test("sample formats", () {

  });*/
  for (String format in formats) {
    var formatter = new DateFormat(format);

    test(format, () {
      print(formatter.format(now));
    });
  }
}