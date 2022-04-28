import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/createStoryScreen.dart';
import 'package:uni_dating/screens/filterOptionsScreen.dart';
import 'package:uni_dating/screens/likes&IntrestScreen.dart';
import 'package:uni_dating/screens/notificationListScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:uni_dating/database_codes/database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tcard/tcard.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

import 'chatImageScreen.dart';

class AddStoryScreen extends BaseRoute {
  final String? currentUserId;
  final User? user;
  final List<String>? fromFilters;

  AddStoryScreen({a, o, this.currentUserId, this.user, this.fromFilters})
      : super(a: a, o: o, r: 'AddStoryScreen');

  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends BaseRouteState {
  TCardController _controller = new TCardController();
  late AnimationController controller;

  TextEditingController anonymousSecretMessage = TextEditingController();

  String? _anonymousSecret;
  int? _leftDirection;
  int? _rightDirection;
  bool? swipingRight= false ;
  bool? swipingLeft = false;

  List<User>? users = [];
  User? thisUniUser;
  List _intrestsList = [];

  final List<String> _imgList = [
    'assets/images/card_new_img.jpg',
    'assets/images/video img_light.png',
    'assets/images/video img_dark.png',
    'assets/images/videoCall.jpg',
    'assets/images/sample3.png',
  ];

  int? _current;

  _AddStoryScreenState() : super();

  Timer? _time;

  @override
  void initState() {
    super.initState();
    setState(() {
      _current = 0;
    });


    controller = AnimationController(vsync: this);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });

    //_init();
    _widgets();
    _setupThisUser();
    // _time = Timer.periodic(Duration(seconds: 2), (timer) {
    //   _widgets();
    // });

    //   get_uniDatingUsers();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  Future<void> leaveMessage(User? superLiked, User? thisUser) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
          TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(

                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              showCursor: true,
                              autofocus: true,
                              keyboardAppearance: Brightness.light,
                              focusNode: FocusScopeNode(),
                              controller: anonymousSecretMessage,
                              style: TextStyle(fontSize: 18.0, color: Theme
                                  .of(context)
                                  .primaryColorLight),
                              decoration: InputDecoration(
                                labelText: 'Leave a Secret message for ${superLiked!
                                    .name!}',
                                labelStyle:
                                Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                                contentPadding: g.isRTL
                                    ? EdgeInsets.only(right: 20)
                                    : EdgeInsets.only(left: 20),
                                focusedBorder: UnderlineInputBorder(

                                  borderSide: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .primaryColorLight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                border: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              onChanged: (input) => _anonymousSecret = input,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Theme
                                          .of(context)
                                          .primaryColorLight),
                                  onPressed: () async {
                                    await usersRef.doc(superLiked.id)
                                        .collection("secreteMessages").doc(
                                        thisUser!.id)
                                        .set({
                                      'message': _anonymousSecret,
                                      'id': thisUser.id,
                                      'name': 'anonymous',
                                      'profileImage': thisUser.profileImageUrl,
                                      'timestamp': Timestamp.now()
                                          .toDate()
                                          .toLocal(),
                                    });

                                    await usersRef.doc(superLiked.id!)
                                        .collection("notification").add({
                                      'id': widget.currentUserId,
                                      'profileImage': thisUser.profileImageUrl,
                                      'text': 'You have a secret message',
                                      'seen': false,
                                      'type': 'secret',
                                      'name': thisUser.name,
                                      'timestamp': Timestamp.now()
                                          .toDate()
                                          .toLocal(),

                                    })
                                        .then((_) {
                                      usersRef.doc(superLiked.id).update({
                                        'notificationNumber': 1,
                                      });
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Send",
                                    textScaleFactor: 0.7,
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
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

  Future showDoneDialog(User? superLiked, User? thisUser) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: CircleAvatar(
                          backgroundImage:
                          NetworkImage(superLiked!.profileImageUrl!),
                          radius: 32,
                        ),
                      ),
                    ),
                    Lottie.asset('assets/79155-heart-lottie-animation.json',
                        //  'https://assets6.lottiefiles.com/packages/lf20_ZKUJ2j.json',

                        height: 200,
                        width: 200,
                        repeat: false,
                        controller: controller,
                        onLoaded: (composition) {
                          controller.duration = composition.duration;

                          usersRef.doc(superLiked.id!).update({
                            'love': FieldValue.increment(1),
                          });
                          DatabaseService.addLikedCard(
                            thisUser!,
                            thisUser.id!,
                            superLiked.intrests!,
                            superLiked.name!,
                            superLiked.email!,
                            superLiked.phoneNumber!,
                            superLiked.id!,
                            superLiked.profileImageUrl!,
                            superLiked.onlineOffline!,
                            superLiked.paid!,
                          );

                          usersRef.doc(superLiked.id!).collection(
                              "notification").add({
                            'id': widget.currentUserId,
                            'profileImage': thisUser.profileImageUrl,
                            'text': 'Super Interested in you',
                            'seen': false,
                            'type': 'like',
                            'name': thisUser.name,
                            'timestamp': Timestamp.now().toDate().toLocal(),

                          }).then((_) {
                            usersRef.doc(superLiked.id).update({
                              'notificationNumber': 1,
                            });
                          });

                          controller.forward();
                        }),
                  ],
                ),
              ),
            ));
  }

  get_uniDatingUsers() async {
    //  print("$_intrestsList,   this is my intrest directly from the database");
    if (widget.fromFilters == null || widget.fromFilters!.length <= 0) {
      List<User> user = await DatabaseService.getUniDatingUsers(
          _intrestsList.toList(), widget.currentUserId!);
      setState(() {
        users = user;
      });
      print("$_intrestsList,   this is my intrest directly from the database");
    }
    else {
      List<User> user = await DatabaseService.getUniDatingUsersFromFilters(
          widget.fromFilters!.toList(), widget.currentUserId!);
      setState(() {
        users = user;
      });
      print("${widget.fromFilters},   this is my intrest from  the filtter");
    }
  }

  _setupThisUser() async {
    usersRef.doc(widget.currentUserId).get().then((querySnapshot) {
      querySnapshot.reference.snapshots().forEach((element) {
        if (element.exists) {
          List myIntrests = element.data()!['intrests'.toString()];
          print('$myIntrests all my intrests');
          //  _intrestsList.add(myIntrests.toString());
          print(myIntrests);
          setState(() {
            //    _intrestsList = myIntrests;
            //  _intrestsList..addAll(myIntrests);
            _intrestsList..addAll(myIntrests);
          });
          get_uniDatingUsers();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("no Matches..."),
            backgroundColor: Theme
                .of(context)
                .primaryColorLight,
          ));
        }
      });
      // setState(() {
      //   _intrestsList!.add(_intrests.toString());
      // });

      print(_intrestsList);
    }).then((value) => get_uniDatingUsers());
  }

  Future<bool?> showWarning(BuildContext context) async =>
      showDialog<bool>(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(
                  'Do you want to leave app?', style: TextStyle(color: Theme
                    .of(context)
                    .primaryColorLight),),
                actions: [
                  TextButton(
                    child: Text('No', style: Theme
                        .of(context)
                        .primaryTextTheme
                        .subtitle2,),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  TextButton(
                      child: Text('Yes', style: Theme
                          .of(context)
                          .accentTextTheme
                          .subtitle2,),
                      onPressed: () {
                        usersRef.doc(widget.currentUserId).update({
                          'onlineOffline': false,
                        });
                        Navigator.pop(context, true);
                      }

                  )
                ],
              )
      );
  var dateNow = Timestamp.fromDate(DateTime.now().toUtc());
  Widget _uiAddStory(BuildContext context, snapshot, User thisUser, [SubscriptionPeriod? subscriptionPeriod]) {
    if (subscriptionPeriod == null)
    {
      print ("passing");

    }

    else{
      if (dateNow.compareTo(subscriptionPeriod.endDate!) > 0) {
        usersRef
            .doc(widget.currentUserId)
            .update({
          'paid': false,
        });
      }
    }
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: users!.length != 0 && users != null
            ? Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: g.scaffoldBackgroundGradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Scaffold(
            appBar: _appBarWidget(thisUser),
            backgroundColor: g.isDarkModeEnable
                ? Color(0xFF03000C)
                : Theme
                .of(context)
                .scaffoldBackgroundColor,
            body: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 18, left: 10, right: 10),
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.53,
                                //MediaQuery.of(context).size.height * 0.54,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(g.isDarkModeEnable
                                        ? 'assets/images/cards_dark.png'
                                        : 'assets/images/cards_light.png'),
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.70,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.75,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Listener(
                                        onPointerMove:
                                            (PointerMoveEvent _event) {
                                          if (_event.delta.dy > 0) {
                                            setState(() {
                                              _leftDirection = 1;
                                              // ignore: null_check_always_fails
                                              _rightDirection = null;

                                              if(_leftDirection ==   1)
                                              {
                                                setState(() {
                                                  swipingRight = false;
                                                  swipingLeft = true;

                                                });
                                              }
                                            });
                                          }
                                          if (_event.delta.dx > 0) {
                                            setState(() {
                                              _rightDirection = 2;
                                              _leftDirection = null;
                                              if(_rightDirection == 2)
                                                {
                                                  setState(() {
                                                    swipingLeft = false;
                                                    swipingRight = true;

                                                  });
                                                }


                                            });
                                          }
                                        },
                                        child: Stack(
                                          children: [
                                            TCard(
                                              cards: _widgets(),
                                              controller: _controller,
                                              onForward: (index, info) {
                                                if (info.direction ==
                                                    SwipDirection.Left) {
                                                  if (users![_current!].id! !=
                                                      widget.currentUserId) {
                                                    DatabaseService
                                                        .addLikedCard(
                                                      thisUser,
                                                      widget.currentUserId!,
                                                      users![_current!]
                                                          .intrests!,
                                                      users![_current!].name!,
                                                      users![_current!]
                                                          .email!,
                                                      users![_current!]
                                                          .phoneNumber ==
                                                          null
                                                          ? ""
                                                          : users![_current!]
                                                          .phoneNumber!,
                                                      users![_current!].id!,
                                                      users![_current!]
                                                          .profileImageUrl!,
                                                      users![_current!]
                                                          .onlineOffline!,
                                                      users![_current!].paid!,
                                                    );
                                                  }

                                                  users![_current!].id! !=
                                                      widget.currentUserId
                                                      ? ScaffoldMessenger.of(
                                                      context)
                                                      .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Interested"),
                                                        backgroundColor: Theme
                                                            .of(context)
                                                            .primaryColorLight,
                                                      ))
                                                      : ScaffoldMessenger.of(
                                                      context)
                                                      .showSnackBar(
                                                      SnackBar(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        content: Text(
                                                            "Kindly Subscribe"),
                                                        backgroundColor: Theme
                                                            .of(context)
                                                            .primaryColorLight,
                                                      ));

                                                  setState(() {
                                                    //    if(users.length == index )
                                                    // {
                                                    //   _controller.reset();
                                                    //   _current = 0;
                                                    //
                                                    // }

                                                    _current = index;
                                                    _leftDirection = 0;
                                                    _rightDirection = 0;
                                                  });
                                                  print(index);
                                                  print(users!.length);
                                                  setState(() {
                                                    swipingRight = false;
                                                    swipingLeft = false;
                                                  });
                                                }
                                                if (info.direction ==
                                                    SwipDirection.Right) {
                                                  setState(() {
                                                    _current = index;
                                                    _leftDirection = 0;
                                                    _rightDirection = 0;
                                                  });
                                                  print(index);
                                                  print(users!.length);
                                                  ScaffoldMessenger.of(
                                                      context)
                                                      .showSnackBar(SnackBar(
                                                    duration: Duration(seconds: 1),
                                                    content: Text(
                                                        "Not Interested"),
                                                    backgroundColor: Theme
                                                        .of(
                                                        context)
                                                        .primaryColorLight,
                                                    //  backgroundColor: Colors.black,
                                                  ));
                                                  setState(() {
                                                    swipingRight = false;
                                                    swipingLeft = false;
                                                  });
                                                }
                                              },
                                              onEnd: () {
                                                _controller.reset();
                                                _current = 0;
                                                setState(() {
                                                  swipingRight = false;
                                                  swipingLeft = false;
                                                });
                                              },
                                            ),
                                            swipingLeft  == true ?   Container(
                                              height: 100.0,
                                              width: 100.0,
                                              child: Lottie.network("https://assets3.lottiefiles.com/packages/lf20_Oa7lbT.json"),
                                            ) : swipingRight == true ? Positioned(
                                              top: 0.1,
                                              right: 0.1,
                                              child: Container(
                                                alignment: Alignment.topRight,
                                                height: 100.0,
                                                width: 100.0,
                                           child:Lottie.network("https://assets7.lottiefiles.com/packages/lf20_Wlgzlq.json") ,
                                         ),
                                            ) : SizedBox.shrink()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF230f4E),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.bug_report,
                                        ),
                                        color: Colors.white,
                                        onPressed: () async{

                                          if(  subscriptionPeriod!.paid == false)
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Only available to paid users")));

                                            }
                                          if(  subscriptionPeriod.paid == true)
                                          {
                                            g.isDarkModeEnable =
                                            !g.isDarkModeEnable;
                                             SharedPreferences sp = await SharedPreferences.getInstance();
                                             sp.setBool('isDarkMode', g.isDarkModeEnable);
                                            Phoenix.rebirth(context);

                                          }





                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             LikesIntrestScreen(
                                          //               currentUserId: widget
                                          //                   .currentUserId,
                                          //               a: widget
                                          //                   .analytics,
                                          //               o: widget
                                          //                   .observer,
                                          //             )));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                alignment: Alignment.bottomLeft,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.6,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8),
                                      child: Row(
                                        children: [
                                          (users!
                                              .elementAt(
                                              _current!)
                                              .id !=
                                              widget
                                                  .currentUserId)
                                              ? CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 35,
                                            child: CircleAvatar(
                                              backgroundImage:
                                              NetworkImage(
                                                  users!.elementAt(_current!)
                                                      .profileImageUrl!
                                              ),
                                              radius: 32,
                                            ),
                                          ) :
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 35,
                                            child: CircleAvatar(
                                              backgroundImage:
                                              NetworkImage(
                                                'https://previews.123rf.com/images/dezydezy/dezydezy1904/dezydezy190400076/123594399-rocket-launch-startup-concept-boost-business-idea.jpg',
                                              ),
                                              radius: 32,
                                            ),
                                          )
                                          ,
                                          Expanded(
                                            child: Padding(
                                              padding: g.isRTL
                                                  ? const EdgeInsets.only(
                                                  right: 6)
                                                  : const EdgeInsets.only(
                                                  left: 6),
                                              child: RichText(
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: (users == null ||
                                                      users!.length ==
                                                          0 ||
                                                      users![_current!]
                                                          .id ==
                                                          null)
                                                      ? " "
                                                      : users![_current!]
                                                      .id !=
                                                      widget
                                                          .currentUserId
                                                      ? "${users![_current!]
                                                      .name}"
                                                      : 'See who likes you',
                                                  // children: [
                                                  //   TextSpan(
                                                  //     text: '${users[_current].name}',
                                                  //
                                                  //     style: Theme.of(context).accentTextTheme.headline3,
                                                  //   ),
                                                  //   TextSpan(
                                                  //     text: '1.5 km away',
                                                  //     style: Theme.of(context).accentTextTheme.subtitle1,
                                                  //   ),
                                                  // ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          child: Container(
                                            height: 50,
                                            padding:
                                            EdgeInsets.only(left: 8),
                                            child: SizedBox(
                                              height: 10,
                                              width: MediaQuery.of(context).size.width / 2.5,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: [
                                                  DotsIndicator(

                                                    dotsCount: users == null ||
                                                        users!.length <= 0
                                                        ? 3
                                                        : users!.length,
                                                    position:
                                                    _current!.toDouble(),
                                                    decorator: DotsDecorator(
                                                      spacing:
                                                      EdgeInsets.all(3),
                                                      color: Colors.transparent,
                                                      activeColor: Colors.white,
                                                      activeShape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5.0),
                                                        side: BorderSide(
                                                            color:
                                                            Colors.white),
                                                      ),
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5.0),
                                                        side: BorderSide(
                                                            color:
                                                            Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        users![_current!].id !=
                                            widget.currentUserId ? IconButton(
                                          icon: Icon(MdiIcons
                                              .messageReplyTextOutline),
                                          color: Colors.white,
                                          onPressed: () async {
                                            await leaveMessage(
                                                users![_current!], thisUser);
                                          },
                                        ) :

                                        IconButton(
                                          icon: Icon(MdiIcons
                                              .eye),
                                          color: Colors.white,
                                          onPressed: () async {
                                            g.isDarkModeEnable
                                                ? Navigator.of(context)
                                                .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomNavigationWidgetDark(
                                                          currentUserId: widget
                                                              .currentUserId,
                                                          currentIndex: 1,
                                                          a: widget.analytics,
                                                          o: widget.observer,
                                                        )))
                                                : Navigator.of(context)
                                                .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomNavigationWidgetLight(
                                                          currentUserId: widget
                                                              .currentUserId,
                                                          currentIndex: 1,
                                                          a: widget.analytics,
                                                          o: widget.observer,
                                                        )
                                                ));
                                          },
                                        )

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 30, bottom: 30),
                        child: users![_current!].id != widget.currentUserId
                            ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                _controller.forward(
                                    direction: SwipDirection.Left);
                                await DatabaseService.addLikedCard(
                                  thisUser,
                                  widget.currentUserId!,
                                  users![_current!].intrests!,
                                  users![_current!].name!,
                                  users![_current!].email!,
                                  users![_current!].phoneNumber!,
                                  users![_current!].id!,
                                  users![_current!].profileImageUrl!,
                                  users![_current!].onlineOffline!,
                                  users![_current!].paid!,
                                );
                                // usersRef.doc(users![_current!].id!).collection("notification").add({
                                //   'id':widget.currentUserId ,
                                //   'profileImage': thisUser.profileImageUrl ,
                                //   'text': 'Interested in you',
                                //   'seen': false,
                                //   'type': 'like',
                                //   'name': thisUser.name,
                                //   'timestamp': Timestamp.now().toDate().toLocal(),
                                //
                                // });
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(0xFF34F07F),
                                radius: 24,
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: _leftDirection == 1
                                      ? Color(0xFF34F07F)
                                      : Colors.white,
                                  child: Icon(
                                    Icons.thumb_up,
                                    color: _leftDirection == 1
                                        ? Colors.white
                                        : Color(0xFF34F07F),
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (users!.length <= 0 ||
                                    users == null) {} else {
                                  await showDoneDialog(
                                      users![_current!], thisUser);
                                  _controller.forward(
                                      direction: SwipDirection.Left);
                                }
                              },
                              child: Container(
                                padding:
                                EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFBC7D),
                                      Color(0xFFEF5533),
                                    ],
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _controller.forward(
                                    direction: SwipDirection.Right);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFF0384F),
                                  radius: 24,
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: _rightDirection == 2
                                        ? Color(0xFFF0384F)
                                        : Colors.white,
                                    child: Icon(
                                      Icons.thumb_down,
                                      color: _rightDirection == 2
                                          ? Colors.white
                                          : Color(0xFFF0384F),
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IntrestScreen(
                                              user: thisUser,
                                              thisProfileUser:
                                              users![_current!],
                                              currentUserId:
                                              widget.currentUserId,
                                              a: widget.analytics,
                                              o: widget.observer,
                                            )));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF2285FA),
                                      Color(0xFF1B40C1),
                                    ],
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    MdiIcons.informationVariant,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            :
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            GestureDetector(
                              onTap: () {
                                g.isDarkModeEnable
                                    ? Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationWidgetDark(
                                              currentUserId: widget
                                                  .currentUserId,
                                              currentIndex: 1,
                                              a: widget.analytics,
                                              o: widget.observer,
                                            )))
                                    : Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationWidgetLight(
                                              currentUserId: widget
                                                  .currentUserId,
                                              currentIndex: 1,
                                              a: widget.analytics,
                                              o: widget.observer,
                                            )
                                    ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF2285FA),
                                      Color(0xFF1B40C1),
                                    ],
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    MdiIcons.eyeCircle,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        )
            : SizedBox.shrink(),
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
        return FutureBuilder<DocumentSnapshot>(
          future: subPeriod.doc(widget.currentUserId).get(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            SubscriptionPeriod sub = SubscriptionPeriod.fromDoc(snapshot.data);
            return _uiAddStory(context, snapshot, thisUser, sub);
          }
        );
      },
    );
  }

  _widgets() {
    List<Widget> _widgetList = [];

    for (int i = 0; i < users!.length; i++) {
      _widgetList.add(
        users![i].id! != widget.currentUserId &&
            (users!.length != 0 && users != null)
            ? Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  users!.length != 0 && users != null
                      ? users![i].profileImageUrl!
                      : '',
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.70,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.70 - 1.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.75 - 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        )
            : Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://previews.123rf.com/images/dezydezy/dezydezy1904/dezydezy190400076/123594399-rocket-launch-startup-concept-boost-business-idea.jpg",
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.70,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.70 - 1.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.75 - 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return _widgetList;
  }

  PreferredSizeWidget _appBarWidget(User thisUser) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CreateStoryScreen(
                                currentUserId: thisUser.id,
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme
                          .of(context)
                          .primaryColorLight,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: g.isRTL
                        ? const EdgeInsets.only(right: 8)
                        : const EdgeInsets.only(left: 8),
                    child: Text(
                      "Add story",
                      style: Theme
                          .of(context)
                          .primaryTextTheme
                          .subtitle2,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon(
                  //   Icons.search,
                  //   color: Theme.of(context).iconTheme.color,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications_rounded),
                          color: Theme
                              .of(context)
                              .iconTheme
                              .color,
                          onPressed: () {
                            usersRef.doc(widget.currentUserId!).update({
                              'notificationNumber': 0,
                            });

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    NotificationListScreen(
                                      currentUserId: widget.currentUserId,
                                      thisProfileUser: thisUser,
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          },
                        ),
                        thisUser.notificationNumber! > 0 ? Positioned(
                          top: 0.1,
                          right: 10.1,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Theme
                                .of(context)
                                .primaryColorLight,
                          ),
                        ) : SizedBox.shrink()
                      ],
                    ),
                  ),
                  IconButton(
                    icon: (Icon(MdiIcons.tuneVerticalVariant)),
                    color: Theme
                        .of(context)
                        .iconTheme
                        .color,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              FilterOptionsScreen(
                                currentUserId: widget.currentUserId,
                                thisProfileUser: thisUser,
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntrestScreen extends BaseRoute {
  final User2? datingUser;
  final String? currentUserId;
  final User? thisProfileUser;
  final User? user;

  IntrestScreen({a,
    o,
    this.datingUser,
    this.currentUserId,
    this.thisProfileUser,
    this.user})
      : super(a: a, o: o, r: 'IntrestScreen');

  @override
  _IntrestScreenState createState() => _IntrestScreenState();
}

class _IntrestScreenState extends BaseRouteState {
  late AnimationController controller;
  int _currentIndex = 0;
  late TabController _tabController;
  User? _newLover;
  final List<String> imgList = [
    'assets/images/profile_img_0.png',
    'assets/images/profile_img_1.png',
    'assets/images/profile_img_2.png',
    'assets/images/profile_img_3.png',
    'assets/images/profile_img_0.png',
  ];

  _IntrestScreenState() : super();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });

    _tabController =
    new TabController(length: 2, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
    _getNewDaters();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future showDoneDialog() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/jumpinghearts.json',
                        //  'https://assets6.lottiefiles.com/packages/lf20_ZKUJ2j.json',

                        height: 200,
                        width: 200,
                        repeat: false,
                        controller: controller,
                        onLoaded: (composition) {
                          controller.duration = composition.duration;
                          controller.forward();
                          usersRef.doc(widget.thisProfileUser!.id!).update({
                            'like': FieldValue.increment(1),
                          }).then((_) {
                            usersRef.doc(widget.thisProfileUser!.id!)
                                .collection("notification").add({
                              'id': widget.currentUserId,
                              'profileImage': widget.user!.profileImageUrl,
                              'text': 'Just liked your profile',
                              'seen': false,
                              'type': 'like',
                              'name': widget.user!.name,
                              'timestamp': Timestamp.now().toDate().toLocal(),

                            })
                                .then((_) {
                              usersRef.doc(widget.thisProfileUser!.id!).update({
                                'notificationNumber': 1,
                              });
                            });
                          });
                        }),
                  ],
                ),
              ),
            ));
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
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.35,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Container(
                      child: Image.network(
                        _newLover == null || _newLover!.profileImageUrl == null
                            ? ''
                            : _newLover!.profileImageUrl!,
                        fit: BoxFit.contain,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(19, 1, 51, 1),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: CircleAvatar(
                  //       backgroundColor: Color(0xFF130032),
                  //       child: IconButton(
                  //         icon: Icon(MdiIcons.messageReplyTextOutline),
                  //         color: Colors.white,
                  //         onPressed: () {
                  //           Navigator.of(context).push(MaterialPageRoute(
                  //               builder: (context) => StartConversionScreen(
                  //                 currentUserId: widget.currentUserId,
                  //                 matchedUserData: widget.datingUser,
                  //                 a: widget.analytics,
                  //                 o: widget.observer,
                  //               )));
                  //         },
                  //       )),
                  // )
                ],
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 8),
                    alignment: Alignment.centerRight,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    color: g.isDarkModeEnable
                        ? Color(0xFF130032)
                        : Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.9,
                    height: 15,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF984cd9),
                          Color(0xFFb245af),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Text(
                                  _newLover == null || _newLover!.name == null
                                      ? ''
                                      : _newLover!.name!,
                                  style: Theme
                                      .of(context)
                                      .primaryTextTheme
                                      .headline1,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Container(
                                  //   height: 30,
                                  //   child: Row(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     children: [
                                  //       Icon(
                                  //         Icons.place,
                                  //         color: Theme.of(context).iconTheme.color,
                                  //         size: 20,
                                  //       ),
                                  //
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.only(left: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color:
                                          Theme
                                              .of(context)
                                              .iconTheme
                                              .color,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 4),
                                          child: Text(
                                            widget.thisProfileUser!.like! < 1000
                                                ? '${widget.thisProfileUser!
                                                .like!}'
                                                : '${widget.thisProfileUser!
                                                .like!}k',
                                            style: Theme
                                                .of(context)
                                                .primaryTextTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.only(left: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          color:
                                          Theme
                                              .of(context)
                                              .iconTheme
                                              .color,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 4),
                                          child: Text(
                                            widget.thisProfileUser!.love! < 1000
                                                ? '${widget.thisProfileUser!
                                                .love!}'
                                                : '${widget.thisProfileUser!
                                                .love!}k',
                                            style: Theme
                                                .of(context)
                                                .primaryTextTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => StartConversionScreen(
                                  //       currentUserId: widget.currentUserId,
                                  //       matchedUserData: widget.datingUser,
                                  //       a: widget.analytics,
                                  //       o: widget.observer,
                                  //     )));
                                },
                                child: InkWell(
                                  onTap: () async {
                                    await showDoneDialog();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.green[200]!,
                                            Colors.green[900]!
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 22,
                                        child: Icon(
                                          Icons.thumb_up,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Not a fan"),
                                    backgroundColor:
                                    Theme
                                        .of(context)
                                        .primaryColorLight,
                                    duration: Duration(seconds: 1),
                                  ));

                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.red[200]!,
                                          Colors.pink[700]!
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 22,
                                      child: Icon(
                                        Icons.thumb_down,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: g.isRTL
                            ? const EdgeInsets.only(right: 20, top: 30)
                            : const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          "Hello Friends!",
                          style: Theme
                              .of(context)
                              .primaryTextTheme
                              .headline3,
                        ),
                      ),
                      Padding(
                        padding: g.isRTL
                            ? const EdgeInsets.only(right: 20, top: 10)
                            : const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          widget.thisProfileUser!.bio!,
                          style: Theme
                              .of(context)
                              .primaryTextTheme
                              .subtitle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: Theme
                              .of(context)
                              .iconTheme
                              .color,
                          onTap: (int index) async {
                            _currentIndex = index;
                            setState(() {});
                          },
                          tabs: [
                            _tabController.index == 0
                                ? Tab(
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
                                  "Pictures",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                                : Text(
                              "Pictures",
                              style: TextStyle(fontSize: 16),
                            ),
                            _tabController.index == 1
                                ? Tab(
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
                                  'Bio',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                                : Text(
                              'Bio',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: (MediaQuery
                            .of(context)
                            .size
                            .height * 0.12),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            StreamBuilder(
                                stream: DatabaseService.getProfilePosts(
                                    widget.thisProfileUser!.id!),
                                builder: (context, AsyncSnapshot snapshot) {
                                  final List<ImagePost>? post = snapshot.data;
                                  if (snapshot.data == null ||
                                      !snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  return post!.length > 0 ? GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      mainAxisSpacing: 2.0,
                                      crossAxisSpacing: 2.0,
                                    ),
                                    itemCount: post.length,
                                    itemBuilder: (ctx, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatImage(
                                                        imageUrl: post[index]
                                                            .image!,
                                                        currentUserId: widget
                                                            .currentUserId,
                                                      )));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: g.isRTL
                                              ? EdgeInsets.only(
                                              top: 20, right: 20)
                                              : EdgeInsets.only(
                                              top: 20, left: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                                color: Colors.white),
                                            color: g.isDarkModeEnable
                                                ? Color(0xFF1D0529)
                                                : Colors.white54,
                                          ),
                                          height: (MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.12),
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          child: GridTile(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                              child: Image.asset(
                                                post[index].image!,
                                                height: (MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.12),
                                                width:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ) :
                                  SizedBox.shrink();
                                }
                            ),
                            Container(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: g.isRTL
                            ? const EdgeInsets.only(right: 20, top: 30)
                            : const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          "Intrests",
                          style: Theme
                              .of(context)
                              .primaryTextTheme
                              .headline3,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 50.0,
                            child: ListView.builder(
                              padding: EdgeInsets.all(8.0),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _newLover == null ||
                                  _newLover!.intrests == null
                                  ? 0
                                  : _newLover!.intrests!.length,
                              itemBuilder: (BuildContext context, index) {
                                List<String> _intrests = [];

                                _intrests..addAll(_newLover!.intrests!);
                                print(_intrests);

                                return Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        MdiIcons.emoticonHappy,
                                        color: Color(0xFFB783EB),
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          "${_intrests[index].toString()}",
                                          style: Theme
                                              .of(context)
                                              .accentTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getNewDaters() async {
    User newLover =
    await DatabaseService.getNewLoverWithIdProfile(widget.thisProfileUser!.id!);
    setState(() {
      _newLover = newLover;
    });
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              await DatabaseService.addLikedCard(
                widget.user,
                widget.currentUserId!,
                widget.thisProfileUser!.intrests!,
                widget.thisProfileUser!.name!,
                widget.thisProfileUser!.email!,
                widget.thisProfileUser!.phoneNumber == null
                    ? ""
                    : widget.thisProfileUser!.phoneNumber!,
                widget.thisProfileUser!.id!,
                widget.thisProfileUser!.profileImageUrl!,
                widget.thisProfileUser!.onlineOffline!,
                widget.thisProfileUser!.paid!,
              );
              await usersRef.doc(widget.thisProfileUser!.id!).collection(
                  "notification").add({
                'id': widget.currentUserId,
                'profileImage': widget.user!.profileImageUrl,
                'text': 'Interested in you',
                'seen': false,
                'type': 'Request',
                'name': widget.user!.name,
                'timestamp': Timestamp.now().toDate().toLocal(),

              });
            },
            child: Container(
              padding: EdgeInsets.only(right: 8),
              alignment: Alignment.centerRight,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: g.isDarkModeEnable
                  ? Color(0xFF130032)
                  : Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              height: 65,
              child: Text(
                  'Add '
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFCC3263),
            width: MediaQuery
                .of(context)
                .size
                .width / 1.9,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
