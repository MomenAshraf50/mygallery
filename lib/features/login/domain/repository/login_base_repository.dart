import 'package:dartz/dartz.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/features/login/domain/entity/login_entity.dart';
import 'package:mygallery/features/login/domain/usecase/login_usecase.dart';

abstract class LogInBaseRepository{

  Future<Either<Failure,LogInEntity>> logIn(LogInParams params);

}