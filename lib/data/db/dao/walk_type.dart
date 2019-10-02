import 'package:floor/floor.dart';
import 'package:spn_flutter/data/db/models/walk_type.dart';

@dao
abstract class WalkTypeDao {
  @Query('SELECT * FROM WalkType')
  Future<List<WalkType>> getAllWalkType();

  @Query('SELECT * FROM WalkType WHERE id = :id')
  Future<WalkType> getWalkTypeById(int id);

  @insert
  Future<void> insertWalkType(WalkType walkType);

  @insert
  Future<List<int>> insertWalkTypes(List<WalkType> walkTypes);
}
