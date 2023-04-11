import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygallery/core/di/injection.dart';
import 'package:mygallery/core/network/local/cache_helper.dart';
import 'package:mygallery/core/util/resources/constants_manager.dart';
import 'package:mygallery/features/home/presentation/controller/home_cubit.dart';
import 'package:mygallery/features/home/presentation/screens/home_gallery.dart';
import 'package:mygallery/features/login/presentation/controller/login_cubit.dart';
import 'package:mygallery/features/login/presentation/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  late Widget widget;
  token = await sl<CacheHelper>().get('token');
  name = await sl<CacheHelper>().get('name');


  if(token != null){
    widget = HomeGallery(name: name!,);
  }else{
    widget = const LogInScreen();
  }

  runApp(MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.widget});

  Widget widget;

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => sl<LogInCubit>()),
        BlocProvider(create: (context) => sl<HomeCubit>()),
      ],
      child: MaterialApp(
        title: 'My Gallery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: widget,
      ),
    );
  }
}

