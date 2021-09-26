import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/MyApp/Model/NotesModel.dart';
import 'package:todo_app/MyApp/utils/UniversalString.dart';

class LocalDatabase {
  static final LocalDatabase localDatabase = LocalDatabase._init();
  LocalDatabase._init();

  static Database? _database;

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
          "CREATE TABLE $TABLE_NAME($AUTO_ID INTEGER PRIMARY KEY, $NOTES_TITLE TEXT, $NOTES_DESCRIPTION TEXT, $NOTES_DATE INTEGER, $NOTES_COLOR INTEGER);");
    });
    return _database!;
  }

//
// ─── INSER DATA IN LOCAL STORAGE ────────────────────────────────────────────────
//
  Future createDb({required NotesModel notesModel}) async {
    final _db = await localDatabase.database;
    try {
      final _id = await _db.insert(
        TABLE_NAME,
        notesModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Data Save");
      print(_id);
      return _id;
    } catch (e) {
      print("EXCEPTION: $e");
    }
  }

//
// ─── FETCH DATA FROM DATABASE ───────────────────────────────────────────────────
//
  Future<List<NotesModel>> readData() async {
    final _db = await localDatabase.database;
    List<NotesModel> list = [];
    final maps = await _db.query(TABLE_NAME);
    for (var i = 0; i < maps.length; i++) {
      list.add(NotesModel.fromMap(maps[i]));
    }
    print("Data Read successFully");
    return list;
  }

  Future close() async {
    _database!.close();
  }

  //
  // ─── DELETE DATA FROM DATABASE ──────────────────────────────────────────────────
  //
  Future<void> delete({required int id}) async {
    try {
      final _db = await localDatabase.database;
      var _id = await _db.delete(TABLE_NAME, where: "id = ?", whereArgs: [id]);
      print("delete succesfully $_id");
    } catch (e) {
      print("Delete exception : $e");
    }
  }

  //
  // ─── UPDATE DATA ────────────────────────────────────────────────────────────────
  //
  Future<void> updateData(
      {required int id,
      required String title,
      required String description}) async {
    try {
      final _db = await localDatabase.database;
      var _id = await _db.update(TABLE_NAME,
          {"$NOTES_TITLE": "$title", "$NOTES_DESCRIPTION": "$description"},
          where: "id = ?", whereArgs: [id]);
      print("Update succesfully $_id");
    } catch (e) {
      print("update Exception : $e");
    }
  }
}
