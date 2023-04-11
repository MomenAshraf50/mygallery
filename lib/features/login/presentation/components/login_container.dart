import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygallery/core/di/injection.dart';
import 'package:mygallery/core/network/local/cache_helper.dart';
import 'package:mygallery/core/util/resources/app_string.dart';
import 'package:mygallery/core/util/resources/colors_manager.dart';
import 'package:mygallery/core/util/resources/constants_manager.dart';
import 'package:mygallery/core/util/resources/extensions_manager.dart';
import 'package:mygallery/core/util/widgets/blur_container.dart';
import 'package:mygallery/core/util/widgets/default_text.dart';
import 'package:mygallery/core/util/widgets/default_text_form_field.dart';
import 'package:mygallery/features/home/presentation/screens/home_gallery.dart';
import 'package:mygallery/features/login/domain/usecase/login_usecase.dart';
import 'package:mygallery/features/login/presentation/controller/login_cubit.dart';
import 'package:mygallery/features/login/presentation/controller/login_states.dart';

class LogInContainer extends StatelessWidget {
  const LogInContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(20.rSp),
        child: BlurContainer(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30.rSp),
                  child: DefaultText(
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.darkGrey,
                    text: AppString.logIn,
                    fontSize: 40.rSp,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.rSp, vertical: 20.rSp),
                  child: DefaultTextFormField(
                    controller: userNameController,
                    keyboardType: TextInputType.emailAddress,
                    hint: AppString.userName,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your email.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.rSp, vertical: 20.rSp),
                  child: DefaultTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    hint: AppString.passWord,
                    isPassword: true,
                    controller: passwordController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your password.';
                      }
                      return null;
                    },
                  ),
                ),
                BlocConsumer<LogInCubit, LogInStates>(
                  listener: (context, state){
                    if(state is LogInSuccessState){
                      sl<CacheHelper>().put('token',state.logInEntity.token);
                      sl<CacheHelper>().put('name',state.logInEntity.userData.name);
                      sl<CacheHelper>().put('id',state.logInEntity..userData.id);
                      sl<CacheHelper>().put('email',state.logInEntity.userData.email);
                      navigateAndFinish(context, HomeGallery(name: state.logInEntity.userData.name,));

                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 50.rSp, top: 10.rSp),
                      child: SizedBox(
                        height: 6.h,
                        width: 70.w,
                        child: state is LogInLoadingState
                            ? Container(
                                width: 70.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: ColorsManager.blue,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(15.rSp)),
                          child: const Center(child: CircularProgressIndicator(color: ColorsManager.white,)),
                              )
                            : MaterialButton(
                                height: 5.h,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.rSp)),
                                color: ColorsManager.blue,
                                onPressed: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if(formKey.currentState!.validate()){
                                    sl<LogInCubit>().logIn(LogInParams(userName: userNameController.text, password: passwordController.text));
                                  }
                                },
                                child: DefaultText(
                                  color: ColorsManager.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.rSp,
                                  text: AppString.submit,
                                ),
                              ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
