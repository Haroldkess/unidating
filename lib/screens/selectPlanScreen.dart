import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/paymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectPlanScreen extends BaseRoute {
  SelectPlanScreen({a, o}) : super(a: a, o: o, r: 'SelectPlanScreen');
  @override
  _SelectPlanScreenState createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends BaseRouteState {
  _SelectPlanScreenState() : super();

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
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppLocalizations.of(context)!.lbl_plan_select,
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.lbl_plan_select_subtitle1,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 6),
                          child: Image.asset(
                            'assets/images/heart.png',
                            height: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      AppLocalizations.of(context)!.lbl_plan_select_subtitle2,
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            MdiIcons.arrowRight,
                            size: 18,
                            color: g.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 8) : const EdgeInsets.only(left: 8),
                          child: Text(
                            'Find out whos following you',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            MdiIcons.arrowRight,
                            size: 18,
                            color: g.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 8) : const EdgeInsets.only(left: 8),
                          child: Text(
                            'Contact popular and new users',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            MdiIcons.arrowRight,
                            size: 18,
                            color: g.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 8) : const EdgeInsets.only(left: 8),
                          child: Text(
                            'Browse profile invisibily &',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Text('Many More...'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Select Your Plan',
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(1.5),
                    height: 65,
                    decoration: g.isDarkModeEnable
                        ? BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          )
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      alignment: Alignment.centerLeft,
                      height: 65,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 10),
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [Color(0xFFDFC6FE), Color(0xFFD369D4)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  Icons.star,
                                  color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Color(0xFFFF5A90),
                                  size: 26,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Starter X',
                                  style: Theme.of(context).primaryTextTheme.subtitle1,
                                ),
                                Text(
                                  '3 Months',
                                  style: Theme.of(context).primaryTextTheme.bodyText2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                size: 18,
                              ),
                              Text(
                                '33.00',
                                style: TextStyle(
                                  color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(1.5),
                    height: 65,
                    decoration: g.isDarkModeEnable
                        ? null
                        : BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: g.isDarkModeEnable ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      height: 65,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 10),
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [Color(0xFFDFC6FE), Color(0xFFD369D4)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  MdiIcons.diamond,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 26,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pro Buddy',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: g.isDarkModeEnable ? Colors.white : Color(0xFF33196B),
                                  ),
                                ),
                                Text(
                                  '6 Months',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                size: 20,
                              ),
                              Text(
                                '60.00',
                                style: TextStyle(
                                  color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(1.5),
                    height: 65,
                    decoration: g.isDarkModeEnable
                        ? BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          )
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 65,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 10),
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [Color(0xFFDFC6FE), Color(0xFFD369D4)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  MdiIcons.crown,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 26,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Starter X',
                                  style: Theme.of(context).primaryTextTheme.subtitle1,
                                ),
                                Text(
                                  '3 Months',
                                  style: Theme.of(context).primaryTextTheme.bodyText2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                size: 18,
                              ),
                              Text(
                                '108.00',
                                style: TextStyle(
                                  color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
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
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                    screenId: 2,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.btn_continue,
                          style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                            MaterialState.pressed,
                          }),
                        ),
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
