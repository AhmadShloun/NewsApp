import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/news_layout.dart';
import 'package:newsapp/shared/bloc_observer.dart';
import 'package:newsapp/shared/components/constants.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:newsapp/shared/styles/themes.dart';

import 'shared/cubit/cubit.dart';

void main() {
  // bool sys = true;

  BlocOverrides.runZoned(
    () async {
      //
      WidgetsFlutterBinding.ensureInitialized();
      //await
      DioHelper.init();
      await CacheHelper.init();

      // CacheHelper.putbool(key: 'isDark', value: false);
      bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

      Widget widget;

      bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
      token = CacheHelper.getData(key: 'token');
      print(token);

      print('onBoarding : $onBoarding');
      HttpOverrides.global = MyHttpOverrides();
      runApp(MyApp(
        isDark: isDark,
        startWidget: NewsLayout(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusnies()),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
