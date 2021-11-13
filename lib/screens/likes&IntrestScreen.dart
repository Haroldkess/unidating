import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/uploadIdScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

class LikesIntrestScreen extends BaseRoute {
  final String? currentUserId;
  LikesIntrestScreen({a, o,this.currentUserId}) : super(a: a, o: o, r: 'LikesIntrestScreen');
  @override
  _LikesIntrestScreenState createState() => _LikesIntrestScreenState();
}

class _LikesIntrestScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _list = [];

  _LikesIntrestScreenState() : super();

  _submitInterest(){

    User user = User(
      intrests: _list

    );
    usersRef.doc(widget.currentUserId).update({

      'intrests': FieldValue.arrayUnion(user.intrests!),
      'filters': FieldValue.arrayUnion(user.intrests!),
    });

  }

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
          appBar: _appBarWidget(),
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Likes, Intrests",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Share your likes & possion with others",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                    Wrap(
                      spacing: 0,
                      runAlignment: WrapAlignment.start,
                      children: [

                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Photography') ? _list.removeWhere((e) => e == 'Photography') : _list.add('Photography');
                            });
                          },
                          child: !_list.contains('Photography')
                              ? Container(
                            padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.photo_camera,
                                  color: Color(0xFF845EB5),
                                  size: 20,
                                ),
                                Padding(
                                  padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                  child: Text(
                                    'Photography',
                                    style: Theme.of(context).accentTextTheme.overline,
                                  ),
                                )
                              ],
                            ),
                          )
                              : Container(
                            margin: EdgeInsets.only(top: 20.0),
                            padding: EdgeInsets.all(1.2),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.42,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Container(
                              padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 60,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.videogame_asset,
                                    color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                    child: Text(
                                      'Photography',
                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Cooking') ? _list.removeWhere((e) => e == 'Cooking') : _list.add('Cooking');
                            });
                          },
                          child: !_list.contains('Cooking')
                              ? Container(
                                  padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                  margin: g.isRTL ? EdgeInsets.only(top: 30, right: 20) : EdgeInsets.only(top: 30, left: 20),
                                  decoration: BoxDecoration(
                                    color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        MdiIcons.cookie,
                                        color: Color(0xFF845EB5),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                        child: Text(
                                          'Cooking',
                                          style: Theme.of(context).accentTextTheme.overline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: g.isRTL ? EdgeInsets.only(top: 30, right: 20) : EdgeInsets.only(top: 30, left: 20),
                                  padding: EdgeInsets.all(1.2),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    height: 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          MdiIcons.cookie,
                                          color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Cooking',
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Video Games') ? _list.removeWhere((e) => e == 'Video Games') : _list.add('Video Games');
                            });
                          },
                          child: !_list.contains('Video Games')
                              ? Container(
                                  padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.videogame_asset,
                                        color: Color(0xFF845EB5),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                        child: Text(
                                          'Video Games',
                                          style: Theme.of(context).accentTextTheme.overline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.all(1.2),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    height: 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.videogame_asset,
                                          color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Video Games',
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Music') ? _list.removeWhere((e) => e == 'Music') : _list.add('Music');
                            });
                          },
                          child: !_list.contains('Music')
                              ? Container(
                            padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                            margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  MdiIcons.music,
                                  color: Color(0xFF845EB5),
                                  size: 20,
                                ),
                                Padding(
                                  padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                  child: Text(
                                    'Music',
                                    style: Theme.of(context).accentTextTheme.overline,
                                  ),
                                )
                              ],
                            ),
                          )
                              : Container(
                            margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                            padding: EdgeInsets.all(1.2),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.42,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Container(
                              padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 60,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    MdiIcons.run,
                                    color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                    child: Text(
                                      'Music',
                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Travelling') ? _list.removeWhere((e) => e == 'Travelling') : _list.add('Travelling');
                            });
                          },
                          child: !_list.contains('Travelling')
                              ? Container(
                            padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.explore_outlined,
                                  color: Color(0xFF845EB5),
                                  size: 20,
                                ),
                                Padding(
                                  padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                  child: Text(
                                    'Travelling',
                                    style: Theme.of(context).accentTextTheme.overline,
                                  ),
                                )
                              ],
                            ),
                          )
                              : Container(
                            margin: EdgeInsets.only(top: 20.0),
                            padding: EdgeInsets.all(1.2),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.42,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Container(
                              padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 60,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    MdiIcons.music,
                                    color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                    child: Text(
                                      'Travelling',
                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Shopping') ? _list.removeWhere((e) => e == 'Shopping') : _list.add('Shopping');
                            });
                          },
                          child: !_list.contains('Shopping')
                              ? Container(
                                  padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                  margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                  decoration: BoxDecoration(
                                    color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Color(0xFF845EB5),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                        child: Text(
                                          'Shopping',
                                          style: Theme.of(context).accentTextTheme.overline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                  padding: EdgeInsets.all(1.2),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    height: 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.shopping_bag_outlined,
                                          color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Shopping',
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        // InkWell(
                        //     onTap: () {
                        //       setState(() {
                        //         _list.contains('Speeches') ? _list.removeWhere((e) => e == 'Speeches') : _list.add('Speeches');
                        //       });
                        //     },
                        //     child: !_list.contains('Speeches')
                        //         ? Container(
                        //             padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                        //             margin: EdgeInsets.only(top: 20),
                        //             decoration: BoxDecoration(
                        //               color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                        //               borderRadius: BorderRadius.circular(35),
                        //             ),
                        //             height: 60,
                        //             width: MediaQuery.of(context).size.width * 0.42,
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Icon(
                        //                   MdiIcons.microphone,
                        //                   color: Color(0xFF845EB5),
                        //                   size: 20,
                        //                 ),
                        //                 Padding(
                        //                   padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                        //                   child: Text(
                        //                     'Speeches',
                        //                     style: Theme.of(context).accentTextTheme.overline,
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           )
                        //         : Container(
                        //             margin: EdgeInsets.only(top: 20.0),
                        //             padding: EdgeInsets.all(1.2),
                        //             height: 60,
                        //             width: MediaQuery.of(context).size.width * 0.42,
                        //             decoration: BoxDecoration(
                        //               gradient: LinearGradient(
                        //                 colors: g.gradientColors,
                        //                 begin: Alignment.topLeft,
                        //                 end: Alignment.bottomRight,
                        //               ),
                        //               borderRadius: BorderRadius.circular(35),
                        //             ),
                        //             child: Container(
                        //               padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                        //               decoration: BoxDecoration(
                        //                 color: g.isDarkModeEnable ? Colors.black : Colors.white,
                        //                 borderRadius: BorderRadius.circular(35),
                        //               ),
                        //               height: 60,
                        //               child: Row(
                        //                 mainAxisSize: MainAxisSize.min,
                        //                 children: [
                        //                   Icon(
                        //                     Icons.shopping_bag_outlined,
                        //                     color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                        //                     size: 20,
                        //                   ),
                        //                   Padding(
                        //                     padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                        //                     child: Text(
                        //                       'Speeches',
                        //                       style: Theme.of(context).primaryTextTheme.subtitle2,
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           )),

                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       _list.contains('Art & Crafts') ? _list.removeWhere((e) => e == 'Art & Crafts') : _list.add('Art & Crafts');
                        //     });
                        //   },
                        //   child: !_list.contains('Art & Crafts')
                        //       ? Container(
                        //           padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                        //           margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                        //           decoration: BoxDecoration(
                        //             color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                        //             borderRadius: BorderRadius.circular(35),
                        //           ),
                        //           height: 60,
                        //           width: MediaQuery.of(context).size.width * 0.42,
                        //           child: Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Icon(
                        //                 Icons.palette,
                        //                 color: Color(0xFF845EB5),
                        //                 size: 20,
                        //               ),
                        //               Padding(
                        //                 padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                        //                 child: Text(
                        //                   'Art & Crafts',
                        //                   style: Theme.of(context).accentTextTheme.overline,
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         )
                        //       : Container(
                        //           margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                        //           padding: EdgeInsets.all(1.2),
                        //           height: 60,
                        //           width: MediaQuery.of(context).size.width * 0.42,
                        //           decoration: BoxDecoration(
                        //             gradient: LinearGradient(
                        //               colors: g.gradientColors,
                        //               begin: Alignment.topLeft,
                        //               end: Alignment.bottomRight,
                        //             ),
                        //             borderRadius: BorderRadius.circular(35),
                        //           ),
                        //           child: Container(
                        //             padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                        //             decoration: BoxDecoration(
                        //               color: g.isDarkModeEnable ? Colors.black : Colors.white,
                        //               borderRadius: BorderRadius.circular(35),
                        //             ),
                        //             height: 60,
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Icon(
                        //                   Icons.palette,
                        //                   color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                        //                   size: 20,
                        //                 ),
                        //                 Padding(
                        //                   padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                        //                   child: Text(
                        //                     'Art & Crafts',
                        //                     style: Theme.of(context).primaryTextTheme.subtitle2,
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        // ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Swimming') ? _list.removeWhere((e) => e == 'Swimming') : _list.add('Swimming');
                            });
                          },
                          child: !_list.contains('Swimming')
                              ? Container(
                                  padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        MdiIcons.swim,
                                        color: Color(0xFF845EB5),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                        child: Text(
                                          'Swimming',
                                          style: Theme.of(context).accentTextTheme.overline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.all(1.2),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    height: 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          MdiIcons.swim,
                                          color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Swimming',
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Drinking') ? _list.removeWhere((e) => e == 'Drinking') : _list.add('Drinking');
                            });
                          },
                          child: !_list.contains('Drinking')
                              ? Container(
                                  padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                  margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                  decoration: BoxDecoration(
                                    color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.wine_bar,
                                        color: Color(0xFF845EB5),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                        child: Text(
                                          'Drinking',
                                          style: Theme.of(context).accentTextTheme.overline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                  padding: EdgeInsets.all(1.2),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    height: 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.wine_bar,
                                          color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Drinking',
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Exstreme Sports') ? _list.removeWhere((e) => e == 'Exstreme Sports') : _list.add('Exstreme Sports');
                            });
                          },
                          child: !_list.contains('Exstreme Sports')
                              ? Container(
                                  padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.sports_rounded,
                                        color: Color(0xFF845EB5),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                        child: Text(
                                          'Extreme Sports',
                                          style: Theme.of(context).accentTextTheme.overline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.all(1.2),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    height: 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.sports_rounded,
                                          color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Extreme Sports',
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _list.contains('Fitness') ? _list.removeWhere((e) => e == 'Fitness') : _list.add('Fitness');
                            });
                          },
                          child: !_list.contains('Fitness')
                              ? Container(
                                  padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                  margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                  decoration: BoxDecoration(
                                    color: g.isDarkModeEnable ? Color(0xFF1B1143) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        MdiIcons.run,
                                        color: Color(0xFF845EB5),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                        child: Text(
                                          'Fitness',
                                          style: Theme.of(context).accentTextTheme.overline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                  padding: EdgeInsets.all(1.2),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Container(
                                    padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: g.isDarkModeEnable ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    height: 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          MdiIcons.run,
                                          color: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Fitness',
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30),
                    //   child: ShaderMask(
                    //     blendMode: BlendMode.srcIn,
                    //     shaderCallback: (Rect bounds) {
                    //       return LinearGradient(
                    //         colors: g.gradientColors,
                    //         begin: Alignment.centerLeft,
                    //         end: Alignment.centerRight,
                    //       ).createShader(bounds);
                    //     },
                    //     child: Text(
                    //       "Load More",
                    //       style: TextStyle(fontSize: 20),
                    //     ),
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 30, bottom: 20),
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
                          onPressed: () async {
                            print(widget.currentUserId);
                          if  (_list.length > 3) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor:
                              Theme.of(context).primaryColorLight,

                              content: Text("You can only select 4 interest"),
                              //  backgroundColor: Colors.black,
                            ));

                          }
                          else{
                            await _submitInterest();

                          }


                            g.isDarkModeEnable
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
                            ));

                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                            //     builder: (context) => UploadIdScreen(
                            //           a: widget.analytics,
                            //           o: widget.observer,
                            //         )));
                          },
                          child: Text("Continue",
                              style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                                MaterialState.pressed,
                              })),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                  Navigator.of(context).pop();
                },
              ),
              // trailing: InkWell(
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigator.of(context).push(MaterialPageRoute(
              //     //     builder: (context) => UploadIdScreen(
              //     //           a: widget.analytics,
              //     //           o: widget.observer,
              //     //         )));
              //   },
              //   child: Text(
              //     "Ignore",
              //     style: Theme.of(context).accentTextTheme.headline6,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
