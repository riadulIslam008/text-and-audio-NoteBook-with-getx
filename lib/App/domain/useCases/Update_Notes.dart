import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/App/domain/entites/Notes_Entity.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';
import 'package:todo_app/App/domain/useCases/Use_Case.dart';

class UpdateNotes extends UseCases<void, NotesEntity> {
  final NotesRepository _notesRepository;

  UpdateNotes(this._notesRepository);

  @override
  Future<Either<AppError, void>> call(NotesEntity notesEntity) async {
    return await _notesRepository.updateNotes(notesEntity: notesEntity);
  }
}
