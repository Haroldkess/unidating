import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartDatingScreen extends BaseRoute {
  StartDatingScreen({a, o}) : super(a: a, o: o, r: 'StartDatingScreen');
  @override
  _StartDatingScreenState createState() => _StartDatingScreenState();
}

class _StartDatingScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _StartDatingScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: g.scaffoldBackgroundGradientColors,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!.lbl_online_dating_app,
                    style: Theme.of(context).primaryTextTheme.headline4,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.lbl_start_dating_subtitle1,
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
                Text(
                  AppLocalizations.of(context)!.lbl_start_dating_subtitle2,
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    AppLocalizations.of(context)!.lbl_start_dating_subtitle3,
                    style: TextStyle(
                      color: g.isDarkModeEnable ? Colors.white70 : Color(0xFF5E50E5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    AppLocalizations.of(context)!.lbl_play_video,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Image.asset(
                  g.isDarkModeEnable ? 'assets/images/start_dating_new.png' : 'assets/images/start_dating_new.png',
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: g.gradientColors,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen(
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.lbl_start_dating,
                        style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                          MaterialState.pressed,
                        }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }
}
