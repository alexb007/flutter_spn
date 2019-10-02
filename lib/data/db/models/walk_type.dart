import 'package:floor/floor.dart';

@Entity(
  tableName: 'WalkType',
)
class WalkType {
  @primaryKey
  final int id;
  final String name;

  WalkType(this.id, this.name);
}
