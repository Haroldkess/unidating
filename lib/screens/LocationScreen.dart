import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationScreen extends BaseRoute {
  LocationScreen({a, o}) : super(a: a, o: o, r: 'LocationScreen');
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _cLocation = new TextEditingController();
  TextEditingController _cNewLocation = new TextEditingController();
  _LocationScreenState() : super();

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
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: SizedBox()),
                  Text(AppLocalizations.of(context)!.lbl_location, style: Theme.of(context).primaryTextTheme.headline1),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.lbl_location_subtitle1,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.lbl_location_subtitle2, style: Theme.of(context).primaryTextTheme.subtitle2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        AppLocalizations.of(context)!.lbl_current_location,
                        style: Theme.of(context).accentTextTheme.headline5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.all(1.2),
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: g.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 60,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        textAlign: TextAlign.start,
                        controller: _cLocation,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.my_location,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          contentPadding: g.isRTL ? EdgeInsets.only(right: 20, top: 15) : EdgeInsets.only(left: 20, top: 15),
                          hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
                          hintText: 'Florida, US',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(1.2),
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: g.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 60,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        textAlign: TextAlign.start,
                        controller: _cNewLocation,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          contentPadding: g.isRTL ? EdgeInsets.only(right: 20, top: 15) : EdgeInsets.only(left: 20, top: 15),
                          hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
                          hintText: AppLocalizations.of(context)!.lbl_search_location_hint,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
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
                          g.isDarkModeEnable
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetDark(
                                        currentIndex: 0,
                                        a: widget.analytics,
                                        o: widget.observer,
                                      )))
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetLight(
                                        currentIndex: 0,
                                        a: widget.analytics,
                                        o: widget.observer,
                                      )));
                        },
                        child: Text(AppLocalizations.of(context)!.btn_continue,
                            style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                              MaterialState.pressed,
                            })),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.lbl_powered_by,
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4, top: 4),
                            child: Image.asset(
                              'assets/images/google_back.png',
                              height: 25,
                              width: 70,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
