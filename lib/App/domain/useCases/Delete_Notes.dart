import 'package:dartz/dartz.dart';
import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';
import 'package:todo_app/App/domain/useCases/Paramitters/Param_ID.dart';
import 'package:todo_app/App/domain/useCases/Use_Case.dart';

class DeleteNotes extends UseCases<void, ParamID> {
  final NotesRepository _notesRepository;

  DeleteNotes(this._notesRepository);

  @override
  Future<Either<AppError, void>> call(ParamID paramID) async {
    return await _notesRepository.deleteNotes(notesId: paramID.id);
  }
}
