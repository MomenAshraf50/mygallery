import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/core/usecase/use_case.dart';
import 'package:mygallery/core/util/resources/constants_manager.dart';
import 'package:mygallery/features/home/domain/usecase/get_gallery_images_usecase.dart';
import 'package:mygallery/features/home/domain/usecase/upload_image_usecase.dart';
import 'package:mygallery/features/home/presentation/controller/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetGalleryImagesUseCase _galleryImagesUseCase;
  final UploadImageUseCase _uploadImageUseCase;

  HomeCubit({required GetGalleryImagesUseCase galleryImagesUseCase,required UploadImageUseCase uploadImageUseCase})
      : _galleryImagesUseCase = galleryImagesUseCase,
        _uploadImageUseCase = uploadImageUseCase,
        super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  void getGalleryImages()async{
    emit(GetGalleryImagesLoadingState());
    final result = await _galleryImagesUseCase(NoParams());

    result.fold((failure){
      emit(GetGalleryImagesErrorState(mapFailureToMessage(failure)));
    }, (data){
      emit(GetGalleryImagesSuccessState(data));
    });
  }

  File? imageFile;

  void pickImage(BuildContext context,ImageSource imageSource) async {

    emit(ImagePickingLoadingState());
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: imageSource);

      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        uploadImage(UploadImageParams(imageFile!));
        emit(ImagePickedSuccessState());
      }
    } catch (e) {
      designToastDialog(context: context, toast: TOAST.error);
      emit(ImagePickedErrorState());
    }
  }
  void uploadImage(UploadImageParams params)async{
    emit(UploadImageLoadingState());
    final result = await _uploadImageUseCase(params);

    result.fold((failure){
      emit(UploadImageErrorState(mapFailureToMessage(failure)));
    }, (data){
      emit(UploadImageSuccessState(data));
    });
  }
}