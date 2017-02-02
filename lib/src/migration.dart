import 'dart:async';
import 'migrator.dart';

abstract class Migration {
  /// The name of the class to generate.
  String get name;

  Future create(Migrator migrator);
  Future destroy(Migrator migrator);
}