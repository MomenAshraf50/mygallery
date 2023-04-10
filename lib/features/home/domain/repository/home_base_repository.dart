import 'package:dartz/dartz.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/features/home/domain/entity/my_gallery_entity.dart';
import 'package:mygallery/features/home/domain/entity/upload_image_entity.dart';
import 'package:mygallery/features/home/domain/usecase/upload_image_usecase.dart';

abstract class HomeBaseRepository{
  Future<Either<Failure,UploadImageEntity>> uploadImage(UploadImageParams params);
  Future<Either<Failure,MyGalleryEntity>> getGalleryImages();
}