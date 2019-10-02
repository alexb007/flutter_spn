import 'package:spn_flutter/data/Constants.dart';
import 'package:spn_flutter/data/db/config/base.dart';

class Floor {
  static final Floor _instance = Floor._internal();

  static Floor get instance => _instance;

  AppDatabase _database;

  Future<AppDatabase> get database async {
    if (_database != null) return _database;

    return await $FloorAppDatabase.databaseBuilder(Constants.DB_NAME).build();
  }

  Floor._internal();
}
