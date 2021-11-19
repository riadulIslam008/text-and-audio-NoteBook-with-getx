import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotesEntity extends Equatable {
  int? id;
  final String title;
  final String description;
  final DateTime time;
  final Color color;

  NotesEntity({
    this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.color,
  });
  @override
  List<Object?> get props => [title, id];
}
