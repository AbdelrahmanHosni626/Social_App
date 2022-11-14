import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  print('when start app $uId');

  if (uId != null) {
    widget = SocialLayoutScreen();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()
        ..getUserData()
        ..getPosts(),
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: SplashScreenView(
          navigateRoute: startWidget,
          duration: 5000,
          imageSize: 130,
          imageSrc: "assets/images/s.png",
          text: "Social App",
          textType: TextType.ColorizeAnimationText,
          textStyle: const TextStyle(
            fontSize: 40.0,
          ),
          colors:  const [
            Colors.red,
            Colors.deepOrange,
            Colors.yellow,
            Colors.redAccent,
          ],
        ),
      ),
    );
  }
}
