import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mygallery/core/di/injection.dart';
import 'package:mygallery/core/util/resources/app_string.dart';
import 'package:mygallery/core/util/resources/colors_manager.dart';
import 'package:mygallery/core/util/resources/extensions_manager.dart';
import 'package:mygallery/core/util/widgets/blur_container.dart';
import 'package:mygallery/core/util/widgets/default_text.dart';
import 'package:mygallery/core/util/widgets/hide_keyboard.dart';
import 'package:mygallery/features/login/presentation/components/login_container.dart';
import 'package:mygallery/features/login/presentation/controller/login_cubit.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: HideKeyboardPage(
          child: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    AppString.logInBackgroundPath,
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(
                        color: ColorsManager.darkGrey,
                        text: 'My',
                        fontSize: 64.rSp,
                        fontWeight: FontWeight.bold,
                      ),
                      DefaultText(
                        color: ColorsManager.darkGrey,
                        text: 'Gallery',
                        fontSize: 64.rSp,
                        fontWeight: FontWeight.bold,
                      ),
                      const LogInContainer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
