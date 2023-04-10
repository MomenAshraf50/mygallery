import 'package:dartz/dartz.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/core/usecase/use_case.dart';
import 'package:mygallery/features/home/domain/entity/my_gallery_entity.dart';
import 'package:mygallery/features/home/domain/repository/home_base_repository.dart';

class GetGalleryImagesUseCase extends UseCase<MyGalleryEntity,NoParams>{

  HomeBaseRepository homeBaseRepository;


  GetGalleryImagesUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, MyGalleryEntity>> call(NoParams params) {
    return homeBaseRepository.getGalleryImages();
  }
}