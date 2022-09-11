import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/ShopLayout.dart';
import 'package:test_app/modules/on_bording/login/loginScreen.dart';
import 'package:test_app/shared/local/cache_Helper.dart';
import 'package:test_app/shared/local/remote/dio_helper.dart';
import 'package:test_app/shared/style/theme.dart';

import 'bloc_observer.dart';
import 'layout/Shop_layoute/cubit/ShopState.dart';
import 'layout/Shop_layoute/cubit/shopCubit.dart';
import 'layout/cubit darkMode/cubit.dart';
import 'modules/on_bording/login/cubit/cubitLogin.dart';
import 'modules/on_bording/onBordingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  //bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScrren();
  } else {
    widget = OnBordingScreen();
  }

  runApp(MyApp(
    //isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: lightTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}
//ShopCubit.get(context).isDark
               // ? ThemeMode.dark
              //  : ThemeMode.light
