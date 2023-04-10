import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/core/usecase/use_case.dart';
import 'package:mygallery/features/login/domain/entity/login_entity.dart';
import 'package:mygallery/features/login/domain/repository/login_base_repository.dart';

class LogInUseCase extends UseCase<LogInEntity,LogInParams> {

  LogInBaseRepository logInBaseRepository;


  LogInUseCase(this.logInBaseRepository);

  @override
  Future<Either<Failure, LogInEntity>> call(LogInParams params) {
    return logInBaseRepository.logIn(params);
  }


}

class LogInParams extends Equatable {
  String userName;
  String password;

  LogInParams({
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props =>[userName,password,];


}
