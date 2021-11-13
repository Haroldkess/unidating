import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/database_codes/database.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/addNewMessageModel.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/chatScreen.dart';
import 'package:uni_dating/screens/selectPlanScreen.dart';
import 'package:uni_dating/screens/startConversionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddMessageScreen extends BaseRoute {
  final String? currentUserId;

  AddMessageScreen({a, o, this.currentUserId})
      : super(a: a, o: o, r: 'AddMessageScreen');

  @override
  _AddMessageScreenState createState() => _AddMessageScreenState();
}

class _AddMessageScreenState extends BaseRouteState {
  TextEditingController _cSearch = new TextEditingController();
  List<User2> matchedNotChatted = [];
  List<User2> matchedChatted = [];

  final List<String> circleImageList = [
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
  ];

  List<AddNewMessage> _addNewMsgList = [
    new AddNewMessage(
        name: 'Belle Benson',
        time: '03:45 PM',
        imgPath: 'assets/images/card_img_0.png',
        messageCount: 2),
    new AddNewMessage(
        name: 'Ruby Diaz',
        time: '11:49 AM',
        imgPath: 'assets/images/card_img_1.png',
        messageCount: 3),
    new AddNewMessage(
        name: 'Myley Corbyon',
        time: 'Yesterday',
        imgPath: 'assets/images/card_img_2.png',
        messageCount: 1),
    new AddNewMessage(
        name: 'Tony Z',
        time: '11:30 PM',
        imgPath: 'assets/images/card_img_1.png',
        messageCount: 0),
    new AddNewMessage(
        name: 'Ruby Raman',
        time: 'Yesterday',
        imgPath: 'assets/images/card_img_4.png',
        messageCount: 1),
  ];

  getMatchedNotChatted() async {
    //  print("$_intrestsList,   this is my intrest directly from the database");
    List<User2> user =
        await DatabaseService.matchedNotChatted(widget.currentUserId!);
    setState(() {
      matchedNotChatted = user;
    });
    //  print("$_intrestsList,   this is my intrest directly from the database");
  }

  getMatchedChatted() async {
    //  print("$_intrestsList,   this is my intrest directly from the database");
    Stream<List<User2>> user =
        DatabaseService.matchedChatted(widget.currentUserId!);
    setState(() {
      matchedChatted = user as List<User2>;
    });
    //  print("$_intrestsList,   this is my intrest directly from the database");
  }

  _AddMessageScreenState() : super();

  Future<bool?> showWarning (BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text('Do you want to leave app?',style: TextStyle(color: Theme.of(context).primaryColorLight),),
        actions: [
          TextButton(
            child: Text('No',style: Theme.of(context).primaryTextTheme.subtitle2,),
            onPressed: ()=> Navigator.pop(context, false),
          ),
          TextButton(
            child: Text('Yes',style: Theme.of(context).accentTextTheme.subtitle2,),
            onPressed: (){
              usersRef.doc(widget.currentUserId).update({
                'onlineOffline': false,
              });
              Navigator.pop(context, true);
            }
          )
        ],
      )
  );


  Widget ui(BuildContext context, AsyncSnapshot snapshot, User _thisUser) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: g.scaffoldBackgroundGradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Scaffold(
            // appBar: _appBarWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: RefreshIndicator(
              onRefresh: () => getMatchedNotChatted(),
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(top: 20),
                      //   padding: EdgeInsets.all(2),
                      //   height: 55,
                      //   decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       colors: g.gradientColors,
                      //       begin: Alignment.topLeft,
                      //       end: Alignment.bottomRight,
                      //     ),
                      //     borderRadius: BorderRadius.circular(35),
                      //   ),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: g.isDarkModeEnable
                      //           ? Colors.black
                      //           : Colors.white,
                      //       borderRadius: BorderRadius.circular(35),
                      //     ),
                      //     height: 55,
                      //     child: Text("Chats"),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Chats",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),
                      ),
                   matchedNotChatted.length > 0 ?  Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "New Matches",
                            style: Theme.of(context).primaryTextTheme.subtitle1,
                          ),
                        ),
                      ) : SizedBox.shrink(),
                      matchedNotChatted.length > 0 ?  Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: matchedNotChatted.length,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  _thisUser.paid == true
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StartConversionScreen(
                                                    currentUserId:
                                                        widget.currentUserId,
                                                    matchedUserData:
                                                        matchedNotChatted[
                                                            index],
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )))
                                      : Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectPlanScreen(
                                                    currentUserId:
                                                        widget.currentUserId,
                                                    thisProfileUser: _thisUser,
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    radius: 26,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xFFF1405B),
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        matchedNotChatted[index]
                                            .profileImageUrl!,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ) :
                      SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "All Messages",
                          style: Theme.of(context).primaryTextTheme.headline3,
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: DatabaseService.matchedChatted(
                              widget.currentUserId!),
                          builder: (context, AsyncSnapshot snapshot) {
                            final List<User2>? userChatList = snapshot.data;
                            if (snapshot.data == null || !snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            // if (userChat.length > 0)
                            // {
                            //   usersRef.doc(widget.currentUserId).collection('Matched').doc(widget.matchedUserData!.id).update({
                            //     'startedChatting': true,
                            //   });
                            //
                            //   usersRef.doc(widget.matchedUserData!.id).collection('Matched').doc(widget.currentUserId).update({
                            //     'startedChatting': true,
                            //   });
                            // }

                            return ListView.builder(
                                itemCount: userChatList!.length,
                                itemBuilder: (ctx, index) {
                                  return StreamBuilder<DocumentSnapshot>(
                                      stream: usersRef
                                          .doc(userChatList[index].id)
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        User user = User.fromDoc(snapshot.data);
                                        return Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: g.isDarkModeEnable
                                                ? Color(0xFF1D0529)
                                                : Colors.white54,
                                          ),
                                          height: 90,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTile(
                                            title: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(1.5),
                                                  margin: g.isRTL
                                                      ? EdgeInsets.only(
                                                          left: 10)
                                                      : EdgeInsets.only(
                                                          right: 10),
                                                  height: 60,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11),
                                                      color: Colors.purple,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.network(
                                                        user.profileImageUrl!,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          //  mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  '${user.name}',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .primaryTextTheme
                                                                      .subtitle1,
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom:
                                                                          10),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 4,
                                                                backgroundColor:
                                                                    user.onlineOffline ==
                                                                            true
                                                                        ? Colors.lightGreenAccent[
                                                                            400]
                                                                        : Colors
                                                                            .redAccent[400],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          '${userChatList[index].lastMessage}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            trailing: Container(
                                              height: 60,
                                              width: 53,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      userChatList[index]
                                                                  .read ==
                                                              false
                                                          ? 'unread'
                                                          : '',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: userChatList[index]
                                                                  .read ==
                                                              false
                                                          ? CircleAvatar(
                                                              radius: 9,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFD6386F),
                                                              child: Text(
                                                                '',
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .headline6,
                                                              ),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 9,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Text(
                                                                '',
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .headline6,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              _thisUser.paid == true
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatScreen(
                                                                a: widget
                                                                    .analytics,
                                                                o: widget
                                                                    .observer,
                                                                currentUserId:
                                                                    widget
                                                                        .currentUserId,
                                                                matchedUserData:
                                                                    userChatList[
                                                                        index],
                                                              )))
                                                  : Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SelectPlanScreen(
                                                                currentUserId:
                                                                    widget
                                                                        .currentUserId,
                                                                thisProfileUser:
                                                                    _thisUser,
                                                                a: widget
                                                                    .analytics,
                                                                o: widget
                                                                    .observer,
                                                              )));

                                              await usersRef
                                                  .doc(widget.currentUserId)
                                                  .collection("Matched")
                                                  .doc(userChatList[index].id)
                                                  .update({
                                                'read': true,
                                              });
                                            },
                                          ),
                                        );
                                      });
                                });
                          },
                        ),
                      )
                    ],
                  )),
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
    getMatchedNotChatted();
    //getMatchedChatted();
  }

  PreferredSizeWidget _appBarWidget() {
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
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: IconButton(
                      icon: Icon(MdiIcons.messageReplyTextOutline),
                      color: Colors.white,
                      iconSize: 20,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: g.isRTL
                        ? const EdgeInsets.only(right: 8)
                        : const EdgeInsets.only(left: 8),
                    child: Text(
                      "Add New Message",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.delete,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
