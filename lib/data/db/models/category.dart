import 'package:floor/floor.dart';

@Entity(tableName: 'Category', foreignKeys: [
  ForeignKey(
    childColumns: ['parent_id'],
    parentColumns: ['id'],
    entity: Category,
  )
])
class Category {
  @primaryKey
  final int id;
  final String title;
  final String code;
  @ColumnInfo(name: 'parent_id')
  final int parentId;
  final String tags;



  Category(this.id, this.title, this.code,  this.parentId, this.tags);
}
