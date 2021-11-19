import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase localDatabase = LocalDatabase._init();
  LocalDatabase._init();

  static Database? _database;

  final String tableName = "notesList";
  final String notesDate = "time";
  final String notesTitle = "titile";
  final String notesDescription = "description";
  final String notesColor = "color";
  final String autoID = "id";

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'notesPath.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $tableName($autoID INTEGER PRIMARY KEY, $notesTitle TEXT, $notesDescription TEXT, $notesDate INTEGER, $notesColor INTEGER);");
    });
    return _database!;
  }
}
