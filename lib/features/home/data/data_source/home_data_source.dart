import 'package:dio/dio.dart';
import 'package:mygallery/core/network/remote/api_endpoints.dart';
import 'package:mygallery/core/network/remote/dio_helper.dart';
import 'package:mygallery/core/util/resources/constants_manager.dart';
import 'package:mygallery/features/home/data/models/my_gallery_model.dart';
import 'package:mygallery/features/home/data/models/upload_image_model.dart';
import 'package:mygallery/features/home/domain/usecase/upload_image_usecase.dart';

abstract class HomeBaseRemoteDataSource {
  Future<UploadImageModel> uploadImage(UploadImageParams params);

  Future<MyGalleryModel> getGalleryImages();
}

class HomeRemoteDataSource extends HomeBaseRemoteDataSource {
  final DioHelper dioHelper;

  HomeRemoteDataSource({required this.dioHelper});

  @override
  Future<MyGalleryModel> getGalleryImages() async {
    final Response response = await dioHelper.get(
      url: myGalleryEndpoint,
      token: token,
    );
    return MyGalleryModel.fromJson(response.data);
  }

  @override
  Future<UploadImageModel> uploadImage(UploadImageParams params) async {
    final Response response = await dioHelper.get(
        url: uploadImageEndpoint,
        token: token,
        data: FormData.fromMap({
          'img': await MultipartFile.fromFile(
            params.image.path,
            filename: Uri.file(params.image.path).pathSegments.last,
          )
        }));
    return UploadImageModel.fromJson(response.data);
  }
}
