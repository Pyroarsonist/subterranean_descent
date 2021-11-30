import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:subterranean_descent/navigation.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  SplashScreenGameState createState() => SplashScreenGameState();
}

class SplashScreenGameState extends State<SplashScreenWidget> {
  //todo: wait for flutter 2.5
  @override
  Widget build(BuildContext context) => Scaffold(
        body: FlameSplashScreen(
          theme: FlameSplashTheme.white,
          onFinish: (context) => Navigation.navigateTo(RouteKey.mainMenu),
        ),
      );
}
