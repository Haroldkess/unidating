import 'dart:async';

import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/provider/local_provider.dart';
import 'package:uni_dating/screens/introScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SplashScreen extends BaseRoute {
  SplashScreen({a, o}) : super(a: a, o: o, r: 'SplashScreen');
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _SplashScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              g.isDarkModeEnable ? 'assets/images/splash_new_dark.jpg' : 'assets/images/splash_new_light.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();

    startTime();
  }

  startTime() {
    try {
      var _duration = new Duration(seconds: 3);
      return new Timer(_duration, () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroScreen()));
      });
    } catch (e) {
      print('Exception SplashScreen.dart - startTime() ' + e.toString());
    }
  }

  _init() {
    try {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        if (g.languageCode == null) {
          var locale = provider.locale ?? Locale('en');
          g.languageCode = locale.languageCode;
        } else {
          provider.setLocale(Locale(g.languageCode!));
        }
        if (g.rtlLanguageCodeLList.contains(g.languageCode)) {
          g.isRTL = true;
        } else {
          g.isRTL = false;
        }
      });
    } catch (e) {
      print('Exception SplashScreen.dart - _init() ' + e.toString());
    }
  }
}
