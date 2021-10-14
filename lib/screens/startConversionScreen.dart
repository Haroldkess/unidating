import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StartConversionScreen extends BaseRoute {
  StartConversionScreen({a, o}) : super(a: a, o: o, r: 'StartConversionScreen');
  @override
  _StartConversionScreenState createState() => _StartConversionScreenState();
}

class _StartConversionScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _StartConversionScreenState() : super();

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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    g.isDarkModeEnable ? 'assets/images/match_new_remove.png' : 'assets/images/match_new_remove.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Text(AppLocalizations.of(context)!.lbl_congrats, style: Theme.of(context).primaryTextTheme.headline1),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.lbl_its_match,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                  Text('Belle and You both Liked each other', style: Theme.of(context).primaryTextTheme.subtitle2),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: IconButton(
                            iconSize: 0,
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              MdiIcons.messageReplyTextOutline,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            AppLocalizations.of(context)!.lbl_coversation,
                            style: TextStyle(
                              color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 20, right: 10),
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.lbl_keep_dating,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
