import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';
import 'package:todo_app/App/domain/useCases/Paramitters/No_Param.dart';
import 'package:todo_app/App/domain/useCases/Use_Case.dart';

class StopRecording extends UseCases<String, NoParam> {
  final NotesRepository _notesRepository;

  StopRecording(this._notesRepository);
  @override
  Future<Either<AppError, String>> call(NoParam params) async {
    return await _notesRepository.stopAudioRecording();
  }
}
