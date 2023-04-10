import 'package:mygallery/features/home/domain/entity/upload_image_entity.dart';

class UploadImageModel extends UploadImageEntity {
  UploadImageModel({required super.status, required super.message});

  factory UploadImageModel.fromJson(Map<String, dynamic> json) {
    return UploadImageModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
