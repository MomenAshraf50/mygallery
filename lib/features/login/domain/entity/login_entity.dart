import 'package:equatable/equatable.dart';

class LogInEntity extends Equatable {
  UserData userData;
  String token;

  LogInEntity({
    required this.userData,
    required this.token,
  });

  @override
  List<Object?> get props =>
      [
        userData,
        token,
      ];
}

class UserData extends Equatable {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String emailCreatedAt;
  String emailUpdatedAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.emailCreatedAt,
    required this.emailUpdatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      emailCreatedAt: json['created_at'],
      emailUpdatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props =>
      [
        id,
        name,
        email,
        emailCreatedAt,
        emailUpdatedAt,
        emailVerifiedAt,
      ];
}
