import 'dart:async';

abstract class Migration {
  String get name;
  Future create();
  Future destroy();
}