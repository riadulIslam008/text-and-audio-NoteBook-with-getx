import 'package:sqflite/sqflite.dart';
import 'package:todo_app/App/data/dataSources/Core/Sql_Lite.dart';
import 'package:todo_app/App/data/models/NotesModel.dart';

abstract class LocalDataSource {
  Future<int> saveNotes({required NotesModel notesModel});
  Future<List<NotesModel>> fecthNotesModel();
  Future<void> deleteNotes({required int notesId});
  Future<void> updateNotes({required NotesModel notesModel});
}

class LocalDataSourceImpl implements LocalDataSource {
  final LocalDatabase _localDatabase;

  LocalDataSourceImpl(this._localDatabase);

  @override
  Future<void> deleteNotes({required int notesId}) async {
    final _db = await _localDatabase.database;
    await _db
        .delete(_localDatabase.tableName, where: "id= ?", whereArgs: [notesId]);
  }

  @override
  Future<List<NotesModel>> fecthNotesModel() async {
    List<NotesModel> notesModelList = [];

    final _db = await _localDatabase.database;
    final notesList = await _db.query(_localDatabase.tableName);

    notesList.forEach((notes) {
      notesModelList.add(NotesModel.fromMap(notes));
    });
    return notesModelList;
  }

  @override
  Future<int> saveNotes({required NotesModel notesModel}) async {
    final _db = await _localDatabase.database;

    final id = await _db.insert(
      _localDatabase.tableName,
      notesModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<void> updateNotes({required NotesModel notesModel}) async {
    final _db = await _localDatabase.database;
    await _db.update(
      _localDatabase.tableName,
      {
        "${_localDatabase.notesTitle}": "${notesModel.titile}",
        "${_localDatabase.notesDescription}": "${notesModel.description}",
      },
      where: "${_localDatabase.autoID} = ?",
      whereArgs: [notesModel.id!],
    );
  }
}
