import 'package:mygallery/features/login/domain/entity/login_entity.dart';

class LogInModel extends LogInEntity {
  LogInModel({required super.userData, required super.token});

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      userData: UserData.fromJson(json['user']),
      token: json['token'],
    );
  }
}
