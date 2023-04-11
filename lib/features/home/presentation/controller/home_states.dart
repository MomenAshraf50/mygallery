import 'package:mygallery/features/home/domain/entity/my_gallery_entity.dart';
import 'package:mygallery/features/home/domain/entity/upload_image_entity.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}
class GetGalleryImagesLoadingState extends HomeStates{}
class GetGalleryImagesSuccessState extends HomeStates{
  MyGalleryEntity myGalleryEntity;

  GetGalleryImagesSuccessState(this.myGalleryEntity);
}
class GetGalleryImagesErrorState extends HomeStates{
  String error;

  GetGalleryImagesErrorState(this.error);
}

class UploadImageLoadingState extends HomeStates{}
class UploadImageSuccessState extends HomeStates{
  UploadImageEntity uploadImageEntity;

  UploadImageSuccessState(this.uploadImageEntity);
}
class UploadImageErrorState extends HomeStates{
  String error;

  UploadImageErrorState(this.error);
}

class ImagePickingLoadingState extends HomeStates{}
class ImagePickedSuccessState extends HomeStates{}

class ImagePickedErrorState extends HomeStates{}