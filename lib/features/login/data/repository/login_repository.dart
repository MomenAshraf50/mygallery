import 'package:dartz/dartz.dart';
import 'package:mygallery/core/error/exceptions.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/features/login/data/data_source/login_data_source.dart';
import 'package:mygallery/features/login/domain/entity/login_entity.dart';
import 'package:mygallery/features/login/domain/repository/login_base_repository.dart';
import 'package:mygallery/features/login/domain/usecase/login_usecase.dart';

class LogInRepository extends LogInBaseRepository{

  final LogInBaseRemoteDataSource logInBaseDataSource;


  LogInRepository({required this.logInBaseDataSource});

  @override
  Future<Either<Failure, LogInEntity>> logIn(LogInParams params) async{
    final logInData = await logInBaseDataSource.logIn(params);
    try{
      return Right(logInData);
    }on ServerException catch (exception){
      return Left(ServerFailure(
        message: exception.message
      ));
    }
  }
}