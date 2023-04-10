import 'package:mygallery/features/home/domain/entity/my_gallery_entity.dart';

class MyGalleryModel extends MyGalleryEntity {
  MyGalleryModel(
      {required super.status, required super.images, required super.message});

  factory MyGalleryModel.fromJson(Map<String, dynamic> json) {
    return MyGalleryModel(
      status: json['status'],
      images: json['data']['images'],
      message: json['message'],
    );
  }
}
