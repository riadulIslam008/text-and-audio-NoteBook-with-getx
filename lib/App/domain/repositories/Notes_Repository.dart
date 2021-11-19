import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:todo_app/App/domain/entites/Notes_Entity.dart';

abstract class NotesRepository {
  Future<Either<AppError, int>> saveNotesInDb(
      {required NotesEntity notesEntity});
  Future<Either<AppError, List<NotesEntity>>> fetchNotesFromDb();
  Future<Either<AppError, void>> deleteNotes({required int notesId});
  Future<Either<AppError, void>> updateNotes(
      {required NotesEntity notesEntity});

  Future<Either<AppError, void>> playAudio(
      {required String filePath, required VoidCallback whenFinished});
  Future<Either<AppError, void>> pauseAudio();
  Future<Either<AppError, void>> resumeAudio();
  Future<Either<AppError, void>> stopAudio();

  Future<Either<AppError, void>> startAudioRecording();
  Future<Either<AppError, String>> stopAudioRecording();
}
