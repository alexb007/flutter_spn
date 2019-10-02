import 'package:floor/floor.dart';
import 'package:spn_flutter/data/db/models/category.dart';

@Entity(tableName: 'Matrix', foreignKeys: [
  ForeignKey(
      childColumns: ['category_id'], parentColumns: ['id'], entity: Category)
], indices: [
  Index(value: ['category_id'])
])
class Matrix {
  @PrimaryKey()
  final int id;

  @ColumnInfo(name: 'category_id')
  final int categoryId;

  String usedInTypes;

  Matrix(this.id, this.categoryId, this.usedInTypes);
}
