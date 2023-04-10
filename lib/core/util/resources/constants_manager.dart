import 'dart:async';
import 'package:mygallery/core/util/resources/colors_manager.dart';

import 'extensions_manager.dart';
import 'package:flutter/material.dart';



String token = '';


enum Style {
  extraSmall,
  small,
  medium,
  large,
  headLarge,
  headMedium,
}



void navigateTo(context,Widget widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context,Widget widget,) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,),
      (route) {
    return false;
  },
);


void debugPrintFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}




Future<void> designToastDialog({
  required BuildContext context,
  required TOAST toast,
  String text = '',
  bool isDismissible = true,
}) async {
  return showDialog(
    barrierDismissible: isDismissible,
    context: context,
    builder: (context) => Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: 80.0,
        color: ColorsManager.white,
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10.0,
                  height: double.infinity,
                  color: chooseColor(toast),
                ),
                horizontalSpace(20.rSp),
                CircleAvatar(
                  radius: 15.0,
                  backgroundColor: chooseColor(toast),
                  child: Icon(
                    chooseIcon(toast),
                    color: ColorsManager.white,
                    size: 18.0,
                  ),
                ),
                horizontalSpace(20.rSp),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chooseTitle(toast, context),
                        style:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: ColorsManager.darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0.rSp,
                                ),
                      ),
                      verticalSpace(4.rSp),
                      Text(
                        text,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorsManager.darkGrey,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0.rSp),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(20.rSp),
              ],
            ),
            if (isDismissible)
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: EdgeInsets.all(10.rSp),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      //navigateAndFinish(context, const MainPage());
                    },
                    child: const CircleAvatar(
                      backgroundColor: ColorsManager.surfaceLight,
                      radius: 10.0,
                      child: Icon(
                        Icons.close,
                        size: 10.0,
                        color: ColorsManager.textPrimaryBlue,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

enum TOAST { success, error, info}

IconData chooseIcon(TOAST toast) {
  late IconData iconData;

  switch (toast) {
    case TOAST.success:
      iconData = Icons.check;
      break;
    case TOAST.error:
      iconData = Icons.error_outline;
      break;
    case TOAST.info:
      iconData = Icons.info_outline;
      break;
  }

  return iconData;
}

Color chooseColor(TOAST toast) {
  late Color color;

  switch (toast) {
    case TOAST.success:
      color = ColorsManager.success;
      break;
    case TOAST.error:
      color = ColorsManager.error;
      break;
    case TOAST.info:
      color = ColorsManager.info;
      break;
  }

  return color;
}

String chooseTitle(TOAST toast, context) {
  late String title;

  switch (toast) {
    case TOAST.success:
      title = 'Success';
      break;
    case TOAST.error:
      title = 'Error';
      break;
    case TOAST.info:
      title ='Info';
      break;
  }

  return title;
}

SizedBox verticalSpace(double size) => SizedBox(height: size);

SizedBox horizontalSpace(double size) => SizedBox(width: size);

BorderRadius borderRadius(double radius) => BorderRadius.circular(radius);