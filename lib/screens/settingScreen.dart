import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/changeLanguageScreen.dart';
import 'package:uni_dating/screens/datingMatchingScreen.dart';
import 'package:uni_dating/screens/liked&LikesScreen.dart';
import 'package:uni_dating/screens/notificationListScreen.dart';
import 'package:uni_dating/screens/rewardScreen.dart';
import 'package:uni_dating/screens/selectPlanScreen.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingScreen extends BaseRoute {
  SettingScreen({a, o}) : super(a: a, o: o, r: 'SettingScreen');
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _SettingScreenState() : super();

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
          appBar: _appBarWidget(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.lbl_settings,
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      AppLocalizations.of(context)!.lbl_settings_subtitle,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      g.isDarkModeEnable
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetDark(
                                    currentIndex: 3,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )))
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetLight(
                                    currentIndex: 3,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_account,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LikedAndLikesScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_likes_likes,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationListScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_notifications,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectPlanScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.vial,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_subscription,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RewardScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.bootstrap,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_dating_rewards,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_payment,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      g.isDarkModeEnable
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetDark(
                                    currentIndex: 2,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )))
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetLight(
                                    currentIndex: 2,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.sms,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_msg_options,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DatingMatchesScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.group,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_manage_matches,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_privacy_options,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_delete_account,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 0.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: g.gradientColors,
                      ),
                    ),
                    child: Divider(),
                  ),
                  GestureDetector(
                    onTap: () async {
                      g.isDarkModeEnable = !g.isDarkModeEnable;
                      // SharedPreferences sp = await SharedPreferences.getInstance();
                      // sp.setBool('isDarkMode', g.isDarkModeEnable);
                      Phoenix.rebirth(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            g.isDarkModeEnable ? Icons.star : Icons.wb_sunny,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_mode,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeLanguageScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.language,
                            color: Theme.of(context).iconTheme.color,
                            size: 18,
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                              child: Text(
                                'Lang',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.medical_services,
                         // Icons.health_and_safety,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_safety,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.help_center,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_help_centre,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.pages,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_terms_cond,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.privacy_tip,
                          color: Theme.of(context).iconTheme.color,
                          size: 18,
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_policy,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
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

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListTile(
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.longArrowAltLeft),
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  g.isDarkModeEnable
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetDark(
                                currentIndex: 3,
                                a: widget.analytics,
                                o: widget.observer,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetLight(
                                currentIndex: 3,
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.drive_file_move),
                color: Theme.of(context).iconTheme.color,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
