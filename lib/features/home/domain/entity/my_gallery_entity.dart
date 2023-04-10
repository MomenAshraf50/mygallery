import 'package:equatable/equatable.dart';

class MyGalleryEntity extends Equatable {
  String status;
  List<String> images;
  String message;

  MyGalleryEntity({
    required this.status,
    required this.images,
    required this.message,
  });

  @override
  List<Object?> get props => [status,images,message,];
}
