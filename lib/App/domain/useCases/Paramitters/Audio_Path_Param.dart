import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AudioPath extends Equatable {
  final String audiopath;
  final VoidCallback whenFinished;

  AudioPath(this.audiopath, this.whenFinished);

  @override
  List<Object?> get props => [];
}
