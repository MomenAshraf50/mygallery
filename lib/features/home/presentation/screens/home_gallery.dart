import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygallery/core/di/injection.dart';
import 'package:mygallery/core/network/local/cache_helper.dart';
import 'package:mygallery/core/util/resources/app_string.dart';
import 'package:mygallery/core/util/resources/colors_manager.dart';
import 'package:mygallery/core/util/resources/constants_manager.dart';
import 'package:mygallery/core/util/resources/extensions_manager.dart';
import 'package:mygallery/core/util/widgets/blur_container.dart';
import 'package:mygallery/core/util/widgets/default_text.dart';
import 'package:mygallery/features/home/presentation/components/gallery_button.dart';
import 'package:mygallery/features/home/presentation/controller/home_cubit.dart';
import 'package:mygallery/features/home/presentation/controller/home_states.dart';
import 'package:mygallery/features/login/presentation/screens/login_screen.dart';

class HomeGallery extends StatelessWidget {
  HomeGallery({Key? key, required this.name}) : super(key: key);
  String name;

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;

    List<dynamic> images = [];

    sl<HomeCubit>().getGalleryImages();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(AppString.galleryBackgroundPath),
            ),
            Padding(
              padding: EdgeInsets.all(20.rSp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            text: AppString.welcome,
                            fontSize: 28.rSp,
                            fontWeight: FontWeight.normal,
                            color: ColorsManager.black,
                          ),
                          DefaultText(
                            text: name,
                            fontSize: 28.rSp,
                            fontWeight: FontWeight.normal,
                            color: ColorsManager.black,
                          ),
                        ],
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 32.rSp,
                        backgroundImage:
                            const AssetImage(AppString.profilePicPath),
                      )
                    ],
                  ),
                  verticalSpace(5.h),
                  Row(
                    children: [
                      Expanded(
                        child: GalleryButton(
                          title: AppString.logOut,
                          onTap: () {
                            navigateAndFinish(context, const LogInScreen());
                            sl<CacheHelper>().clear('token');
                            sl<CacheHelper>().clear('name');
                            sl<CacheHelper>().clear('email');
                            sl<CacheHelper>().clear('id');
                          },
                          imgPath: AppString.logOutIconPath,
                        ),
                      ),
                      horizontalSpace(5.w),
                      Expanded(
                        child: GalleryButton(
                          title: AppString.upload,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: BlurContainer(
                                      child: SizedBox(
                                        height: 30.h,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 50.rSp,
                                              horizontal: 20.rSp),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: GalleryButton(
                                                  title: AppString.gallery,
                                                  onTap: () {
                                                    sl<HomeCubit>().pickImage(
                                                        context,
                                                        ImageSource.gallery);
                                                  },
                                                  width: 40.w,
                                                  imgPath: AppString
                                                      .galleryIconPath,
                                                  isSvg: false,
                                                ),
                                              ),
                                              verticalSpace(5.h),
                                              Expanded(
                                                child: GalleryButton(
                                                  title: AppString.camera,
                                                  width: 40.w,
                                                  onTap: () {
                                                    sl<HomeCubit>().pickImage(
                                                        context,
                                                        ImageSource.camera);
                                                  },
                                                  imgPath: AppString
                                                      .cameraIconPath,
                                                  isSvg: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          imgPath: AppString.uploadIconPath,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(3.h),
                  Expanded(
                    child: BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) {
                        if (state is GetGalleryImagesSuccessState) {
                          images = state.myGalleryEntity.images;
                        }
                        if (state is UploadImageSuccessState) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          sl<HomeCubit>().getGalleryImages();
                        }
                        if (state is UploadImageLoadingState) {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: SizedBox(
                                      height: 10.h,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ));
                        }
                      },
                      builder: (context, state) {
                        return state is GetGalleryImagesLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10.rSp,
                                crossAxisSpacing: 10.rSp,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                children:
                                    List.generate(images.length, (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.rSp),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              images[index],
                                            ),
                                            fit: BoxFit.cover)),
                                  );
                                }),
                              );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
