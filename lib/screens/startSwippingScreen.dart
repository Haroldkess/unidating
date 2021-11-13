import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartSwippingScreen extends BaseRoute {
  StartSwippingScreen({a, o}) : super(a: a, o: o, r: 'StartSwippingScreen');
  @override
  _StartSwippingScreenState createState() => _StartSwippingScreenState();
}

class _StartSwippingScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _StartSwippingScreenState() : super();

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
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    g.isDarkModeEnable ? 'assets/images/unmatch_new_remove.png' : 'assets/images/unmatch_new_remove.png',
                  ),
                ),
                Text(
                  "Be Patient",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Dont loose heart, keep browsing to",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                ),
                Text(
                  "find your best match",
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: g.gradientColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          "Start Swiping",
                          style: TextStyle(fontSize: 22),
                        )),
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
