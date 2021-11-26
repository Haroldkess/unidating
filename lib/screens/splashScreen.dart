import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/provider/local_provider.dart';
import 'package:uni_dating/screens/introScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

import '../google_sign_in.dart';

class SplashScreen extends BaseRoute {
  final String? currentUserId;

  SplashScreen({a, o,this.currentUserId}) : super(a: a, o: o, r: 'SplashScreen');
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var dateNow = Timestamp.fromDate(DateTime.now().toUtc());
  _SplashScreenState() : super();

  @override
  void initState() {
    super.initState();
    //   Provider.of<GoogleSignInProvider>(context, listen:  false);
    //  _init();
    print(widget.currentUserId);
    startTime();

  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    if (firstTime != null && !firstTime) {
      // Not first time
      return Timer(Duration(seconds: 20), () =>   g.isDarkModeEnable
          ? Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavigationWidgetDark(
            currentUserId: widget.currentUserId,
            currentIndex: 0,
            a: widget.analytics,
            o: widget.observer,
          )))
          : Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavigationWidgetLight(
            currentUserId: widget.currentUserId,
            currentIndex: 0,
            a: widget.analytics,
            o: widget.observer,
          )
      )));
    } else {// First time
      prefs.setBool('first_time', false);
      return Timer(Duration(seconds: 3), () =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>     IntroScreen(
                currentUserId: widget.currentUserId,
                a: widget.analytics,
                o: widget.observer,
              )
          ))
      );
    }
  }
Widget ui (BuildContext context)
  {


    return SafeArea(
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: g.isDarkModeEnable ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
               radius: 50,
                child: Image.asset(
                  g.isDarkModeEnable ? 'assets/logo.png' : 'assets/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("Online dating app for everyone",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ui(context);
  }


  @override
  void dispose() {
    super.dispose();

  }

  // startTime() {
  //   try {
  //     var _duration = new Duration(seconds: 3);
  //     return new Timer(_duration, () {
  //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroScreen(
  //         currentUserId: widget.currentUserId,
  //
  //       )));
  //     });
  //   } catch (e) {
  //     print('Exception SplashScreen.dart - startTime() ' + e.toString());
  //   }
  // }

  _init() {
    try {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        if (g.languageCode == null) {
          var locale = provider.locale != null ? Locale('en') : Locale('en') ;
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
