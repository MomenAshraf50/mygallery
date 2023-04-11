import 'package:mygallery/features/login/domain/entity/login_entity.dart';

abstract class LogInStates{}

class LogInInitialState extends LogInStates{}
class LogInLoadingState extends LogInStates{}
class LogInSuccessState extends LogInStates{
  LogInEntity logInEntity;

  LogInSuccessState(this.logInEntity);
}
class LogInErrorState extends LogInStates{
  String error;

  LogInErrorState(this.error);
}