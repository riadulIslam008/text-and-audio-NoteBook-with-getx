import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';
import 'package:todo_app/App/domain/useCases/Paramitters/No_Param.dart';
import 'package:todo_app/App/domain/useCases/Use_Case.dart';

class StopAudio extends UseCases<void, NoParam> {
  final NotesRepository _notesRepository;

  StopAudio(this._notesRepository);
  @override
  Future<Either<AppError, void>> call(NoParam params) async {
    return await _notesRepository.stopAudio();
  }
}
