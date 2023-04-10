import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/core/usecase/use_case.dart';
import 'package:mygallery/features/home/domain/entity/upload_image_entity.dart';
import 'package:mygallery/features/home/domain/repository/home_base_repository.dart';

class UploadImageUseCase extends UseCase<UploadImageEntity,UploadImageParams>{

  HomeBaseRepository homeBaseRepository;


  UploadImageUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, UploadImageEntity>> call(UploadImageParams params) {
    return homeBaseRepository.uploadImage(params);
  }
}

class UploadImageParams extends Equatable{
  File image;

  UploadImageParams(this.image);

  @override
  List<Object?> get props => [image];



}