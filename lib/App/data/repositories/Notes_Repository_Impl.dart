import 'package:flutter/material.dart';
import 'package:todo_app/App/data/dataSources/local/Local_Data_Source.dart';
import 'package:todo_app/App/data/dataSources/local/Sound_Player.dart';
import 'package:todo_app/App/data/dataSources/local/Sound_Recorder.dart';
import 'package:todo_app/App/data/models/NotesModel.dart';
import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/App/domain/entites/Notes_Entity.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';

class NotesRepositoryImpl extends NotesRepository {
  final LocalDataSource _localDataSource;
  final SoundPlayer _soundPlayer;
  final AudioRecorder _audioRecorder;

  NotesRepositoryImpl(
      this._localDataSource, this._soundPlayer, this._audioRecorder);

  @override
  Future<Either<AppError, List<NotesModel>>> fetchNotesFromDb() async {
    try {
      final response = await _localDataSource.fecthNotesModel();
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, int>> saveNotesInDb(
      {required NotesEntity notesEntity}) async {
    try {
      final response = await _localDataSource.saveNotes(
          notesModel: NotesModel.fromMapNotesEntity(notesEntity));
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> deleteNotes({required int notesId}) async {
    try {
      final response = await _localDataSource.deleteNotes(notesId: notesId);
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> updateNotes(
      {required NotesEntity notesEntity}) async {
    try {
      final response = await _localDataSource.updateNotes(
          notesModel: NotesModel.fromMapNotesEntity(notesEntity));
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> pauseAudio() async {
    try {
      final response = await _soundPlayer.pause();
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> stopAudio() async {
    try {
      final response = await _soundPlayer.stop();
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> playAudio(
      {required String filePath, required VoidCallback whenFinished}) async {
    try {
      final response = await _soundPlayer.play(
          filePath: filePath, whenFinished: whenFinished);
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> resumeAudio() async {
    try {
      final response = await _soundPlayer.resume();
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> startAudioRecording() async {
    try {
      final response = await _audioRecorder.startRecording();
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, String>> stopAudioRecording() async {
    try {
      final response = await _audioRecorder.stopRecording();
      return Right(response);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
