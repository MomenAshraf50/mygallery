import 'package:dartz/dartz.dart';
import 'package:mygallery/core/error/exceptions.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/features/home/data/data_source/home_data_source.dart';
import 'package:mygallery/features/home/domain/entity/my_gallery_entity.dart';
import 'package:mygallery/features/home/domain/entity/upload_image_entity.dart';
import 'package:mygallery/features/home/domain/repository/home_base_repository.dart';
import 'package:mygallery/features/home/domain/usecase/upload_image_usecase.dart';

class HomeRepository extends HomeBaseRepository{

  HomeBaseRemoteDataSource homeBaseDataSource;


  HomeRepository({required this.homeBaseDataSource});

  @override
  Future<Either<Failure, MyGalleryEntity>> getGalleryImages()async{
    final myGalleryEntity = await homeBaseDataSource.getGalleryImages();
    try{
      return Right(myGalleryEntity);
  }on ServerException catch(exception){
      return left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, UploadImageEntity>> uploadImage(UploadImageParams params) async{
    final uploadImageEntity = await homeBaseDataSource.uploadImage(params);
    try{
      return Right(uploadImageEntity);
    }on ServerException catch(exception){
      return left(ServerFailure(message: exception.message));
    }
  }
}