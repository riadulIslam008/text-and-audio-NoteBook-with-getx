import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';
import 'package:todo_app/App/domain/useCases/Paramitters/Audio_Path_Param.dart';
import 'package:todo_app/App/domain/useCases/Use_Case.dart';

class PlayRecordedAudio extends UseCases<void, AudioPath> {
  final NotesRepository _notesRepository;

  PlayRecordedAudio(this._notesRepository);

  @override
  Future<Either<AppError, void>> call(AudioPath params) async {
    return await _notesRepository.playAudio(
        filePath: params.audiopath, whenFinished: params.whenFinished);
  }
}
