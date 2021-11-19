import 'package:equatable/equatable.dart';

class ParamID extends Equatable {
  final int id;

  ParamID(this.id);
  @override
  List<Object?> get props =>[id];
}
