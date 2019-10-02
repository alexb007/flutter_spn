// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CategoryDao _categoryDaoInstance;

  MatrixDao _matrixDaoInstance;

  WalkTypeDao _walkTypeDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER, `title` TEXT, `code` TEXT, `parent_id` INTEGER, `tags` TEXT, FOREIGN KEY (`parent_id`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Matrix` (`id` INTEGER, `category_id` INTEGER, `usedInTypes` TEXT, FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `WalkType` (`id` INTEGER, `name` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE INDEX `index_Matrix_category_id` ON `Matrix` (`category_id`)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  MatrixDao get matrixDao {
    return _matrixDaoInstance ??= _$MatrixDao(database, changeListener);
  }

  @override
  WalkTypeDao get walkTypeDao {
    return _walkTypeDaoInstance ??= _$WalkTypeDao(database, changeListener);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'code': item.code,
                  'parent_id': item.parentId,
                  'tags': item.tags
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _categoryMapper = (Map<String, dynamic> row) => Category(
      row['id'] as int,
      row['title'] as String,
      row['code'] as String,
      row['parent_id'] as int,
      row['tags'] as String);

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  @override
  Future<List<Category>> getAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM Category',
        mapper: _categoryMapper);
  }

  @override
  Future<Category> getCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM Category WHERE id = ?',
        arguments: <dynamic>[id], mapper: _categoryMapper);
  }

  @override
  Future<List<Category>> getCategoryChildren(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Category WHERE parent_id = ?',
        arguments: <dynamic>[id], mapper: _categoryMapper);
  }

  @override
  Future<List<Category>> getCategoryByWalkType(String walkTypeId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Category WHERE parent_id IN (SELECT id FROM Category WHERE id IN (SELECT category_id FROM Matrix WHERE `usedInTypes` LIKE ?))',
        arguments: <dynamic>[walkTypeId],
        mapper: _categoryMapper);
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(
        category, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertCategories(List<Category> categories) {
    return _categoryInsertionAdapter.insertListAndReturnIds(
        categories, sqflite.ConflictAlgorithm.abort);
  }
}

class _$MatrixDao extends MatrixDao {
  _$MatrixDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _matrixInsertionAdapter = InsertionAdapter(
            database,
            'Matrix',
            (Matrix item) => <String, dynamic>{
                  'id': item.id,
                  'category_id': item.categoryId,
                  'usedInTypes': item.usedInTypes
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _matrixMapper = (Map<String, dynamic> row) => Matrix(
      row['id'] as int,
      row['category_id'] as int,
      row['usedInTypes'] as String);

  final InsertionAdapter<Matrix> _matrixInsertionAdapter;

  @override
  Future<List<Matrix>> getAllMatrix() async {
    return _queryAdapter.queryList('SELECT * FROM Matrix',
        mapper: _matrixMapper);
  }

  @override
  Future<Matrix> getMatrixById(int id) async {
    return _queryAdapter.query('SELECT * FROM Matrix WHERE id = ?',
        arguments: <dynamic>[id], mapper: _matrixMapper);
  }

  @override
  Future<Matrix> getMatrixByCategoryId(int categoryId) async {
    return _queryAdapter.query('SELECT * FROM Matrix WHERE category_id = ?',
        arguments: <dynamic>[categoryId], mapper: _matrixMapper);
  }

  @override
  Future<void> insertMatrix(Matrix matrix) async {
    await _matrixInsertionAdapter.insert(
        matrix, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertMatrixes(List<Matrix> matrix) {
    return _matrixInsertionAdapter.insertListAndReturnIds(
        matrix, sqflite.ConflictAlgorithm.abort);
  }
}

class _$WalkTypeDao extends WalkTypeDao {
  _$WalkTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _walkTypeInsertionAdapter = InsertionAdapter(
            database,
            'WalkType',
            (WalkType item) =>
                <String, dynamic>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _walkTypeMapper = (Map<String, dynamic> row) =>
      WalkType(row['id'] as int, row['name'] as String);

  final InsertionAdapter<WalkType> _walkTypeInsertionAdapter;

  @override
  Future<List<WalkType>> getAllWalkType() async {
    return _queryAdapter.queryList('SELECT * FROM WalkType',
        mapper: _walkTypeMapper);
  }

  @override
  Future<WalkType> getWalkTypeById(int id) async {
    return _queryAdapter.query('SELECT * FROM WalkType WHERE id = ?',
        arguments: <dynamic>[id], mapper: _walkTypeMapper);
  }

  @override
  Future<void> insertWalkType(WalkType walkType) async {
    await _walkTypeInsertionAdapter.insert(
        walkType, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertWalkTypes(List<WalkType> walkTypes) {
    return _walkTypeInsertionAdapter.insertListAndReturnIds(
        walkTypes, sqflite.ConflictAlgorithm.abort);
  }
}
