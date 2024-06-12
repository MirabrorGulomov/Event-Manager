import 'package:event_manager/data/models/event_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 4, // Increment the version number
        onCreate: _createDB,
        onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE events (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      location TEXT NOT NULL,
      date TEXT NOT NULL,
      time TEXT NOT NULL,
      color INTEGER NOT NULL
    )
  ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute(
          'ALTER TABLE events ADD COLUMN time TEXT NOT NULL DEFAULT ""');
    }
  }

  Future<List<Event>> fetchEventsByMonth(DateTime month) async {
    final db = await database;
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    final List<Map<String, dynamic>> maps = await db.query(
      'events',
      where: "date >= ? AND date <= ?",
      whereArgs: [firstDay.toIso8601String(), lastDay.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<Event> createEvent(Event event) async {
    final db = await instance.database;
    try {
      final id = await db.insert('events', event.toMap());
      print('Event created successfully with ID: $id');
      return event.copy(id: id);
    } catch (e) {
      print('Failed to create event: $e');
      throw Exception('Failed to create event');
    }
  }

  Future<List<Event>> fetchEventsByDate(String date) async {
    final db = await instance.database;
    final maps = await db.query(
      'events',
      columns: [
        'id',
        'title',
        'description',
        'location',
        'date',
        'time',
        'color',
      ],
      where: 'date=?',
      whereArgs: [date],
    );
    if (maps.isNotEmpty) {
      return maps.map((map) => Event.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  Future<int> updateEvent(Event event) async {
    final db = await instance.database;
    return db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(int id) async {
    final db = await instance.database;
    return db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
