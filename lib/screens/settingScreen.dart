import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/changeLanguageScreen.dart';
import 'package:uni_dating/screens/datingMatchingScreen.dart';
import 'package:uni_dating/screens/liked&LikesScreen.dart';
import 'package:uni_dating/screens/likes&IntrestScreen.dart';
import 'package:uni_dating/screens/notificationListScreen.dart';
import 'package:uni_dating/screens/rewardScreen.dart';
import 'package:uni_dating/screens/selectPlanScreen.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import 'edit_profile.dart';

class SettingScreen extends BaseRoute {
  final String? currentUserId;
  final User? thisProfileUser;

  SettingScreen({a, o,this.currentUserId,this.thisProfileUser}) : super(a: a, o: o, r: 'SettingScreen');
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _SettingScreenState() : super();

  Future<void> deleteAccount() async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
          TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.width / 4,
                width: MediaQuery.of(context).size.width / 0.5,

                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sure you want to delete your account?",style: Theme.of(context).accentTextTheme.subtitle2),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 15.0,right: 5.0),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Theme.of(context).primaryColorLight),
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          await googleSignIn.signOut();
                                          await usersRef.doc(widget.currentUserId).delete();

                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MyApp()),
                                                  (route) => false);



                                        },
                                        child: Text(
                                          "Delete",
                                          textScaleFactor: 0.7,
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 15.0,left: 5.0),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Theme.of(context).primaryColorLight),
                                        onPressed: () async {

                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "No",
                                          textScaleFactor: 0.7,
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[],
            );
          });
        });
  }


  Widget ui (BuildContext context, AsyncSnapshot snapshot, User thisUser){
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
                    "Settings",
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Manage your settings for best app use",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      g.isDarkModeEnable
                          ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetDark(
                            currentUserId: widget.currentUserId,
                            currentIndex: 3,
                            a: widget.analytics,
                            o: widget.observer,
                          )))
                          : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetLight(
                            currentUserId: widget.currentUserId,
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
                                "Account",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfilePage(
                        thisProfileUser: widget.thisProfileUser,
                        a: widget.analytics,
                        o: widget.observer,
                        currentUserId: widget.currentUserId,
                      )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person_outline,
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
                                "Edit Profile",
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
                            currentUserId: widget.currentUserId,
                            thisProfileUser: thisUser,
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
                                "Notifications",
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
                          builder: (context) => LikesIntrestScreen(
                            currentUserId: widget.currentUserId,
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
                                'Edit Interests',
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
                            currentUserId: widget.currentUserId,
                            thisProfileUser: thisUser,
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
                                "Manage Subscriptions",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                  // InkWell(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => RewardScreen(
                  //           currentUserId: widget.currentUserId,
                  //           thisProfileUser: thisUser,
                  //           a: widget.analytics,
                  //           o: widget.observer,
                  //         )));
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Icon(
                  //           FontAwesomeIcons.bootstrap,
                  //           color: Theme.of(context).iconTheme.color,
                  //           size: 18,
                  //         ),
                  //         ShaderMask(
                  //           blendMode: BlendMode.srcIn,
                  //           shaderCallback: (Rect bounds) {
                  //             return LinearGradient(
                  //               colors: g.gradientColors,
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight,
                  //             ).createShader(bounds);
                  //           },
                  //           child: Padding(
                  //             padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                  //             child: Text(
                  //               "Dating Rewards",
                  //               style: TextStyle(fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Icon(
                  //         Icons.account_balance_wallet_outlined,
                  //         color: Theme.of(context).iconTheme.color,
                  //         size: 18,
                  //       ),
                  //       ShaderMask(
                  //         blendMode: BlendMode.srcIn,
                  //         shaderCallback: (Rect bounds) {
                  //           return LinearGradient(
                  //             colors: g.gradientColors,
                  //             begin: Alignment.centerLeft,
                  //             end: Alignment.centerRight,
                  //           ).createShader(bounds);
                  //         },
                  //         child: Padding(
                  //           padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                  //           child: Text(
                  //             "Payments",
                  //             style: TextStyle(fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      g.isDarkModeEnable
                          ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetDark(
                            currentUserId: widget.currentUserId,
                            currentIndex: 2,
                            a: widget.analytics,
                            o: widget.observer,
                          )))
                          : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetLight(
                            currentUserId: widget.currentUserId,
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
                                "Message Options",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //         builder: (context) => DatingMatchesScreen(
                  //           currentUserId: widget.currentUserId,
                  //           a: widget.analytics,
                  //           o: widget.observer,
                  //         )));
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Icon(
                  //           Icons.group,
                  //           color: Theme.of(context).iconTheme.color,
                  //           size: 18,
                  //         ),
                  //         ShaderMask(
                  //           blendMode: BlendMode.srcIn,
                  //           shaderCallback: (Rect bounds) {
                  //             return LinearGradient(
                  //               colors: g.gradientColors,
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight,
                  //             ).createShader(bounds);
                  //           },
                  //           child: Padding(
                  //             padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                  //             child: Text(
                  //               "Manage Matches",
                  //               style: TextStyle(fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Icon(
                  //         Icons.lock,
                  //         color: Theme.of(context).iconTheme.color,
                  //         size: 18,
                  //       ),
                  //       ShaderMask(
                  //         blendMode: BlendMode.srcIn,
                  //         shaderCallback: (Rect bounds) {
                  //           return LinearGradient(
                  //             colors: g.gradientColors,
                  //             begin: Alignment.centerLeft,
                  //             end: Alignment.centerRight,
                  //           ).createShader(bounds);
                  //         },
                  //         child: Padding(
                  //           padding: g.isRTL ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
                  //           child: Text(
                  //             "Privacy Options",
                  //             style: TextStyle(fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  InkWell(
                    onTap: ()async {
                      await deleteAccount();
                    },
                    child: Padding(
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
                                "Delete Account",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
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
                                "Mode",
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
                              "Help Centre",
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
                              "Terms & Conditions",
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
                              "Privacy Policy",
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
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: usersRef.doc(widget.currentUserId).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
        User thisUser = User.fromDoc(snapshot.data);
        return ui(context, snapshot, thisUser);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  final googleSignIn = GoogleSignIn();


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
                            currentUserId: widget.currentUserId,
                                currentIndex: 3,
                                a: widget.analytics,
                                o: widget.observer,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetLight(
                            currentUserId: widget.currentUserId,
                                currentIndex: 3,
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.drive_file_move),
                color: Theme.of(context).iconTheme.color,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await googleSignIn.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp()),
                          (route) => false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
