import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE notes ( 
        id $idType, 
        title $textType,
        content $textType,
        createdAt $textType,
        updatedAt $textType
      )
    ''');
  }

  /// Thêm một ghi chú mới vào cơ sở dữ liệu.
  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert('notes', note.toMap());
    return note.copyWith(id: id);
  }
  
  /// Đọc tất cả các ghi chú từ cơ sở dữ liệu.
  Future<List<Note>> readAll() async {
    final db = await instance.database;
    const orderBy = 'updatedAt DESC';
    final result = await db.query('notes', orderBy: orderBy);

    return result.map((json) => Note.fromMap(json)).toList();
  }

  /// Cập nhật một ghi chú hiện có.
  Future<int> update(Note note) async {
    final db = await instance.database;
    return db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// Xóa một ghi chú dựa trên ID.
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
