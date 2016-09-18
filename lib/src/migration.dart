import 'dart:async';
import 'migrator.dart';

abstract class Migration {
  String get name;

  Future create(Migrator migrator);
  Future destroy(Migrator migrator);
}