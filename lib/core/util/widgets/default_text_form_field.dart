import 'package:flutter/material.dart';
import 'package:mygallery/core/util/resources/colors_manager.dart';
import 'package:mygallery/core/util/resources/extensions_manager.dart';

class DefaultTextFormField extends StatelessWidget {
  DefaultTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    this.isPassword = false,
  }) : super(key: key);
  String hint;
  TextEditingController controller;
  bool isPassword;
  TextInputType keyboardType;
  String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 15.rSp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.rSp),
          color: ColorsManager.white),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
            hintStyle:
                TextStyle(color: ColorsManager.darkGrey.withOpacity(0.5)),
            hintText: hint,
            border: InputBorder.none),
      ),
    );
  }
}
