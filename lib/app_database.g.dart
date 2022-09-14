// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

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
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AppDao? _appdaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductTable` (`id` INTEGER, `pname` TEXT, `categoryId` INTEGER, `price` REAL NOT NULL, FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER, `name` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AppDao get appdao {
    return _appdaoInstance ??= _$AppDao(database, changeListener);
  }
}

class _$AppDao extends AppDao {
  _$AppDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'ProductTable',
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'pname': item.name,
                  'categoryId': item.categoryId,
                  'price': item.price
                },
            changeListener),
        _productUpdateAdapter = UpdateAdapter(
            database,
            'ProductTable',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'pname': item.name,
                  'categoryId': item.categoryId,
                  'price': item.price
                },
            changeListener),
        _productDeletionAdapter = DeletionAdapter(
            database,
            'ProductTable',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'pname': item.name,
                  'categoryId': item.categoryId,
                  'price': item.price
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final UpdateAdapter<Product> _productUpdateAdapter;

  final DeletionAdapter<Product> _productDeletionAdapter;

  @override
  Stream<List<Product>> getAllProducts() {
    return _queryAdapter.queryListStream('SELECT * FROM ProductTable',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int?,
            name: row['pname'] as String?,
            price: row['price'] as double,
            categoryId: row['categoryId'] as int?),
        queryableName: 'ProductTable',
        isView: false);
  }

  @override
  Stream<Product?> getOneProduct(int id) {
    return _queryAdapter.queryStream('SELECT * FROM ProductTable WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int?,
            name: row['pname'] as String?,
            price: row['price'] as double,
            categoryId: row['categoryId'] as int?),
        arguments: [id],
        queryableName: 'ProductTable',
        isView: false);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ProductTable');
  }

  @override
  Future<int> addOneProduct(Product p) {
    return _productInsertionAdapter.insertAndReturnId(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOneProduct(Product p) {
    return _productUpdateAdapter.updateAndReturnChangedRows(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteOneProduct(Product p) {
    return _productDeletionAdapter.deleteAndReturnChangedRows(p);
  }
}
