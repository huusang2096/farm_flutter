import 'dart:async';

import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import '../../../locator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation animation,
      delayedAnimation,
      muchDelayAnimation,
      transfor,
      fadeAnimation;
  AnimationController animationController;

  final _appPref = locator<AppPref>();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    transfor = BorderRadiusTween(
            begin: BorderRadius.circular(125.0),
            end: BorderRadius.circular(0.0))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.ease));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    new Timer(new Duration(seconds: 3), () async {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoute.homeScreen, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: new Container(
              padding: EdgeInsets.all(20),
              decoration: new BoxDecoration(color: backgroundColor),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Column(
                      children: [
                        Images.logo.loadImage(),
                        SizedBox(height: 10),
                        Text('farmgate_social'.tr,
                            style: titleNew.copyWith(color: appIconColor))
                      ],
                    ),
                  )),
                ],
              ),
            ),
          );
        });
  }
}
