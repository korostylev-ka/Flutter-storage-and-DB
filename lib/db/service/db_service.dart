import 'package:flutter_storage/db/dto/person_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  late final Future<Database> database;
  static DBService? service;

  static DBService instance() {
    if (service == null) {
      service = DBService();
      service!.init();
    }
    return service!;
  }

  void init() async {
    database = openDatabase(
      join(await getDatabasesPath(), PersonEntity.dbFileName),
      onCreate: (db, version) {
        return db.execute(PersonEntity.createDB);
      },
      version: 1,
    );
  }

  Future<void> insert(PersonEntity personEntity) async {
    final db = await database;
    await db.insert(
      PersonEntity.table,
      personEntity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PersonEntity>> list() async {
    final db = await database;
    final List<Map<String, Object?>> personsMap = await db.query(
      PersonEntity.table,
    );
    return [
      for (final {
            'id': id as String,
            'firstName': firstName as String,
            'lastName': lastName as String,
            'phone': phone as String,
          }
          in personsMap)
        PersonEntity.of(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
        ),
    ];
  }

  Future<void> update(PersonEntity personEntity) async {
    final db = await database;
    await db.update(
      PersonEntity.table,
      personEntity.toMap(),
      where: 'id = ?',
      whereArgs: [personEntity.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await database;
    await db.delete(
        PersonEntity.table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
