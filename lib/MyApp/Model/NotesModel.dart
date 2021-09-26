import 'dart:convert';

import 'package:flutter/material.dart';

class NotesModel {
   int? id;
  final String titile;
  final String description;
  final DateTime time;
  final Color color;

  NotesModel({
    this.id,
    required this.titile,
    required this.description,
    required this.time,
    required this.color,
  });

  NotesModel copyWith({
    int? id,
    String? titile,
    String? description,
    DateTime? time,
    Color? color,
  }) {
    return NotesModel(
      id: id ?? this.id,
      titile: titile ?? this.titile,
      description: description ?? this.description,
      time: time ?? this.time,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titile': titile,
      'description': description,
      'time': time.millisecondsSinceEpoch,
      'color': color.value,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      titile: map['titile'],
      description: map['description'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      color: Color(map['color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) => NotesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotesModel(id: $id, titile: $titile, description: $description, time: $time, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotesModel &&
      other.id == id &&
      other.titile == titile &&
      other.description == description &&
      other.time == time &&
      other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      titile.hashCode ^
      description.hashCode ^
      time.hashCode ^
      color.hashCode;
  }
}
