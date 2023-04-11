import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mygallery/core/util/resources/colors_manager.dart';
import 'package:mygallery/core/util/resources/constants_manager.dart';
import 'package:mygallery/core/util/resources/extensions_manager.dart';
import 'package:mygallery/core/util/widgets/default_text.dart';

class GalleryButton extends StatelessWidget {
  GalleryButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.imgPath,
    this.height,
    this.isSvg = true,
    this.width,
  }) : super(key: key);
  double? height;
  double? width;
  String title;
  String imgPath;
  VoidCallback onTap;
  bool isSvg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: 10.rSp, horizontal: 20.rSp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.rSp),
        color: ColorsManager.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            isSvg ? SvgPicture.asset(imgPath) : Image.asset(imgPath),
            horizontalSpace(3.w),
            DefaultText(
                fontWeight: FontWeight.normal,
                color: ColorsManager.black,
                text: title,
                fontSize: 18.rSp)
          ],
        ),
      ),
    );
  }
}
