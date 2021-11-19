import 'package:dartz/dartz.dart';
import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:todo_app/App/domain/entites/Notes_Entity.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';
import 'package:todo_app/App/domain/useCases/Paramitters/No_Param.dart';
import 'package:todo_app/App/domain/useCases/Use_Case.dart';

class FetchAllNotes extends UseCases<List<NotesEntity>, NoParam> {
  final NotesRepository _notesRepository;

  FetchAllNotes(this._notesRepository);

  @override
  Future<Either<AppError, List<NotesEntity>>> call(NoParam noParam) async {
    return await _notesRepository.fetchNotesFromDb();
  }
}
