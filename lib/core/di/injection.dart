import 'package:get_it/get_it.dart';
import 'package:mygallery/features/home/data/data_source/home_data_source.dart';
import 'package:mygallery/features/home/data/repository/home_repository.dart';
import 'package:mygallery/features/home/domain/repository/home_base_repository.dart';
import 'package:mygallery/features/home/domain/usecase/get_gallery_images_usecase.dart';
import 'package:mygallery/features/home/domain/usecase/upload_image_usecase.dart';
import 'package:mygallery/features/home/presentation/controller/home_cubit.dart';
import 'package:mygallery/features/login/data/data_source/login_data_source.dart';
import 'package:mygallery/features/login/data/repository/login_repository.dart';
import 'package:mygallery/features/login/domain/repository/login_base_repository.dart';
import 'package:mygallery/features/login/domain/usecase/login_usecase.dart';
import 'package:mygallery/features/login/presentation/controller/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/network/local/cache_helper.dart';
import '/core/network/remote/dio_helper.dart';
import '/core/network/repository.dart';

final sl = GetIt.instance;
class ServiceLocator{
  Future<void> init() async {
    // Bloc
    sl.registerLazySingleton<LogInCubit>(() => LogInCubit(logInUseCase: sl()));
    sl.registerLazySingleton<HomeCubit>(() => HomeCubit(galleryImagesUseCase: sl(),uploadImageUseCase: sl()));

    sl.registerLazySingleton<Repository>(
          () => RepoImplementation(
        dioHelper: sl(),
        cacheHelper: sl(),
      ),
    );

    // Repository
    sl.registerLazySingleton<LogInBaseRepository>(
          () => LogInRepository(logInBaseDataSource: sl()),
    );
    //
    sl.registerLazySingleton<HomeBaseRepository>(
          () => HomeRepository(homeBaseDataSource: sl(),),
    );

    // Use cases
    sl.registerLazySingleton(() => LogInUseCase(sl()));
    sl.registerLazySingleton(() => UploadImageUseCase(sl()));
    sl.registerLazySingleton(() => GetGalleryImagesUseCase(sl()));


    //Data sources
    sl.registerLazySingleton<LogInBaseRemoteDataSource>(
          () => LogInRemoteDataSource(dioHelper: sl()),
    );


    sl.registerLazySingleton<HomeBaseRemoteDataSource>(
          () => HomeRemoteDataSource(dioHelper: sl()),
    );

    // Core
    sl.registerLazySingleton<DioHelper>(
          () => DioImpl(),
    );

    sl.registerLazySingleton<CacheHelper>(
          () => CacheImpl(
        sl(),
      ),
    );

    //! External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
  }
}
