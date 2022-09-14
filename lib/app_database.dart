import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_example/app_dao.dart';
import 'package:floor_example/app_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Product, Category])
abstract class AppDatabase extends FloorDatabase {
  AppDao get appdao;
}
