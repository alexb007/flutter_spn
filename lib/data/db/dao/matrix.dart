import 'package:floor/floor.dart';
import 'package:spn_flutter/data/db/models/matrix.dart';

@dao
abstract class MatrixDao {
  @Query('SELECT * FROM Matrix')
  Future<List<Matrix>> getAllMatrix();

  @Query('SELECT * FROM Matrix WHERE id = :id')
  Future<Matrix> getMatrixById(int id);

  @Query('SELECT * FROM Matrix WHERE category_id = :categoryId')
  Future<Matrix> getMatrixByCategoryId(int categoryId);

  @insert
  Future<void> insertMatrix(Matrix matrix);

  @insert
  Future<List<int>> insertMatrixes(List<Matrix> matrix);
}