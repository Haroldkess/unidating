import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RewardScreen extends BaseRoute {
  final User? thisProfileUser;
  final String? currentUserId;
  RewardScreen({a, o,this.currentUserId,this.thisProfileUser}) : super(a: a, o: o, r: 'RewardScreen');
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends BaseRouteState {
  _RewardScreenState() : super();

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
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _openPlatinumRewardDialog();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 75,
                      width: MediaQuery.of(context).size.width,
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
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 75,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'dating',
                                  style: Theme.of(context).primaryTextTheme.headline1,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    padding: EdgeInsets.only(left: 4, right: 4),
                                    height: 30,
                                    color: Colors.black,
                                    alignment: Alignment.center,
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
                                        'PLATINUM',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Priority Likes, See who Likes you & More',
                              style: Theme.of(context).primaryTextTheme.overline,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _openGoldRewardDialog();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 75,
                      width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 75,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'dating',
                                  style: Theme.of(context).primaryTextTheme.headline1,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.only(left: 4, right: 4),
                                  height: 25,
                                  color: Color(0xFFFFD335),
                                  alignment: Alignment.center,
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
                                      'GOLD',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'See who Likes you & More',
                              style: Theme.of(context).primaryTextTheme.overline,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _openPlusRewardDialog();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 75,
                      width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 75,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'dating',
                                  style: Theme.of(context).primaryTextTheme.headline1,
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
                                  child: Icon(
                                    Icons.add,
                                    size: 28,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Unlimited Likes & More',
                              style: Theme.of(context).primaryTextTheme.overline,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _openBoostDialog();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 75,
                      width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 75,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: g.isDarkModeEnable ? null : Colors.white,
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: g.gradientColors,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  Icons.trending_up_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            g.isDarkModeEnable
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      'Get boosts to increase your matches!',
                                      style: Theme.of(context).accentTextTheme.headline4,
                                    ),
                                  )
                                : ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: g.gradientColors,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ).createShader(bounds);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Get boosts to increase your matches!',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                          ],
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

  _openPlusRewardDialog() {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SimpleDialog(
              insetPadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: g.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Get Dating Plus',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 28,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'Unlimited Likes',
                                style: Theme.of(context).accentTextTheme.headline4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Send as many Likes as you want',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '12',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.16,
                                padding: EdgeInsets.all(1.5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: g.gradientColors,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.16,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '6',
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                      ),
                                      Text(
                                        'months',
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                        child: Text(
                                          '₹300.0/mo',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      ),
                                      Text(
                                        'Save 32%',
                                        style: Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                child: Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF7B49FF),
                                        Color(0xFFFA457E),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '12',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
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
                              Navigator.of(context).pop();
                            },
                            child: Text("Continue",
                                style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                                  MaterialState.pressed,
                                })),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Exception - rewardScreen.dart - _openPlusRewardDialog(): ' + e.toString());
    }
  }

  _openGoldRewardDialog() {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SimpleDialog(
              insetPadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: g.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Get Dating Gold',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 28,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                '1 Free Boost Every Month',
                                style: Theme.of(context).accentTextTheme.headline4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '12',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.16,
                                padding: EdgeInsets.all(1.5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: g.gradientColors,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.16,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '6',
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                      ),
                                      Text(
                                        'months',
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                        child: Text(
                                          '₹300.0/mo',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      ),
                                      Text(
                                        'Save 32%',
                                        style: Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                child: Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF7B49FF),
                                        Color(0xFFFA457E),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '1',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
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
                              Navigator.of(context).pop();
                            },
                            child: Text("Continue",
                                style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                                  MaterialState.pressed,
                                })),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Exception - rewardScreen.dart - _openGoldRewardDialog(): ' + e.toString());
    }
  }

  _openPlatinumRewardDialog() {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SimpleDialog(
              insetPadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: g.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Get Dating Platinum',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.paperPlane,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 28,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'Unlimited Likes',
                                style: Theme.of(context).accentTextTheme.headline4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Send as many Likes as you want',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '12',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.16,
                                padding: EdgeInsets.all(1.5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: g.gradientColors,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.16,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '6',
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                      ),
                                      Text(
                                        'months',
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                        child: Text(
                                          '₹300.0/mo',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      ),
                                      Text(
                                        'Save 32%',
                                        style: Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                child: Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF7B49FF),
                                        Color(0xFFFA457E),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '1',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
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
                              Navigator.of(context).pop();
                            },
                            child: Text("Continue",
                                style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                                  MaterialState.pressed,
                                })),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Exception - rewardScreen.dart - _openPlatinumRewardDialog(): ' + e.toString());
    }
  }

  _openBoostDialog() {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SimpleDialog(
              insetPadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: g.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Up to',
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      '10.5k',
                                      style: Theme.of(context).textTheme.overline,
                                    ),
                                    Text(
                                      'Views',
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'Unlimited Likes',
                                style: Theme.of(context).accentTextTheme.headline4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Send as many Likes as you want',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '12',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.16,
                                padding: EdgeInsets.all(1.5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: g.gradientColors,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.16,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '6',
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                      ),
                                      Text(
                                        'months',
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                        child: Text(
                                          '₹300.0/mo',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      ),
                                      Text(
                                        'Save 32%',
                                        style: Theme.of(context).textTheme.caption,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                child: Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF7B49FF),
                                        Color(0xFFFA457E),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '12',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  Text(
                                    'months',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '₹255.00/mo',
                                      style: Theme.of(context).primaryTextTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
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
                              Navigator.of(context).pop();
                            },
                            child: Text("BOOST ME",
                                style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                                  MaterialState.pressed,
                                })),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Exception - rewardScreen.dart - _openBoostDialog(): ' + e.toString());
    }
  }
}
