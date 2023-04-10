import 'package:equatable/equatable.dart';

class UploadImageEntity extends Equatable{

  String status;
  String message;

  UploadImageEntity({required this.status,required this.message});

  @override
  List<Object?> get props => [status,message];


}