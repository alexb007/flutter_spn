import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

import 'package:spn_flutter/data/Constants.dart';
import 'package:spn_flutter/data/db/dao/category.dart';
import 'package:spn_flutter/data/db/dao/matrix.dart';
import 'package:spn_flutter/data/db/dao/walk_type.dart';
import 'package:spn_flutter/data/db/models/category.dart';
import 'package:spn_flutter/data/db/models/matrix.dart';
import 'package:spn_flutter/data/db/models/walk_type.dart';

part 'base.g.dart';

@Database(version: Constants.DB_VERSION, entities: [Category, Matrix, WalkType])
abstract class AppDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
  MatrixDao get matrixDao;
  WalkTypeDao get walkTypeDao;
}


