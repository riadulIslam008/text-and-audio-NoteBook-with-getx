import 'package:dartz/dartz.dart';
import 'package:todo_app/App/Core/errors/App_Error.dart';

abstract class UseCases<Type, Params>{
   Future<Either<AppError, Type>> call(Params params);
}

//Type---- What does the Use Case Return.

//Params ---------- what is Required to call Api.