import 'package:floor/floor.dart';
import 'package:spn_flutter/data/db/models/category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM Category')
  Future<List<Category>> getAllCategories();

  @Query('SELECT * FROM Category WHERE id = :id')
  Future<Category> getCategoryById(int id);

  @Query('SELECT * FROM Category WHERE parent_id = :id')
  Future<List<Category>> getCategoryChildren(int id);

  @Query(
      "SELECT * FROM Category WHERE parent_id IN (SELECT id FROM Category WHERE id IN (SELECT category_id FROM Matrix WHERE `usedInTypes` LIKE :walkTypeId))")
  Future<List<Category>> getCategoryByWalkType(String walkTypeId);

  @insert
  Future<void> insertCategory(Category category);

  @insert
  Future<List<int>> insertCategories(List<Category> categories);
}
