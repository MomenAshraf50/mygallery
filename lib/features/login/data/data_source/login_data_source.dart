import 'package:dio/dio.dart';
import 'package:mygallery/core/network/remote/api_endpoints.dart';
import 'package:mygallery/core/network/remote/dio_helper.dart';
import 'package:mygallery/features/login/data/models/login_model.dart';
import 'package:mygallery/features/login/domain/usecase/login_usecase.dart';

abstract class LogInBaseRemoteDataSource {
  Future<LogInModel> logIn(LogInParams params);
}

class LogInRemoteDataSource extends LogInBaseRemoteDataSource {
  final DioHelper dioHelper;

  LogInRemoteDataSource({required this.dioHelper});

  @override
  Future<LogInModel> logIn(LogInParams params) async {
    final Response response = await dioHelper.post(
      url: logInEndpoint,
      data: {
        'email': params.userName,
        'password':params.password,
      },
    );
    return LogInModel.fromJson(response.data);
  }
}
