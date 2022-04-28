import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' hide context;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/scheduler.dart';
import 'package:uni_dating/api/firebase_api.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/database_codes/database.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/chatImageScreen.dart';
import 'package:uni_dating/screens/videoCallingScreen.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:uni_dating/widgets/drawerMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatScreen extends BaseRoute {
  final String? currentUserId;
  final User2? matchedUserData;

  ChatScreen({a, o, this.currentUserId, this.matchedUserData})
      : super(a: a, o: o, r: 'ChatScreen');

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  int _currentIndex = 0;
  ScrollController? _listScrollController = ScrollController();

  ScrollController? _listScrollController2 = ScrollController();
  FocusNode? myFocusNode =
      FocusNode(descendantsAreFocusable: false, canRequestFocus: true);
  AnimationController? _controller;
  Animation? _animation;
  TextEditingController _cMessage = new TextEditingController();

  showKeyboard() => myFocusNode!.requestFocus();

  hideKeyboard() => myFocusNode!.unfocus();

  _ChatScreenState() : super();

  Widget messageList() {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _listScrollController
    //       .jumpTo(_listScrollController.position.maxScrollExtent);
    // });
    return StreamBuilder(
      stream: DatabaseService.getUserChatAsStreams(
          widget.currentUserId!, widget.matchedUserData!.id!),
      builder: (context, AsyncSnapshot snapshot) {
        final List<UserChat>? userChat = snapshot.data;
        if (snapshot.data == null || !snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (userChat!.length > 0) {
          usersRef
              .doc(widget.currentUserId)
              .collection('Matched')
              .doc(widget.matchedUserData!.id)
              .update({
            'startedChatting': true,
          });

          usersRef
              .doc(widget.matchedUserData!.id)
              .collection('Matched')
              .doc(widget.currentUserId)
              .update({
            'startedChatting': true,
          });
        }

        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _listScrollController2!.animateTo(
            _listScrollController2!.position.maxScrollExtent,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        });
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _listScrollController!.animateTo(
            _listScrollController!.position.maxScrollExtent,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        });

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 50),
          controller: _listScrollController2,
          reverse: false,
          shrinkWrap: true,
          itemCount: userChat.length,
          itemBuilder: (context, index) {
            UserChat _userChat = userChat[index];
            // mention the arrow syntax if you get the time
            return chatMessageItem(_userChat);
          },
        );
      },
    );
  }

  Widget chatMessageItem(UserChat chat) {
    int timestamp = chat.timestamp!.millisecondsSinceEpoch;

    var chatTime = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: chat.senderId == widget.currentUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: chat.senderId == widget.currentUserId
            ? Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.77,
                      //   height: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                        color: g.isDarkModeEnable
                            ? Color(0xFF3B1159)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: ListTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('You',
                                            style: g.isDarkModeEnable
                                                ? Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle1
                                                : Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      chat.type == "image" ?  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatImage(
                                        imageUrl: chat.message ,
                                        currentUserId: widget.currentUserId,
                                      ))):
                                      print('tapped');
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: chat.type == "text"
                                          ? Text(
                                              chat.message!,
                                              maxLines: 50,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText2,
                                            )
                                          : Image.network(chat.message!),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            chatTime.hour > 0 && chatTime.hour < 12
                                ? '${chatTime.hour.toString()}:${chatTime.minute.toString()} AM '
                                : '${chatTime.hour.toString()}:${chatTime.minute.toString()} PM ',
                            style: Theme.of(context).primaryTextTheme.overline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      // height: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                        color: g.isDarkModeEnable
                            ? Color(0xFF1C0726)
                            : Colors.white60,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('${chat.name}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection:
                                                    TextDirection.ltr,
                                                textAlign: TextAlign.left,
                                                style: g.isDarkModeEnable
                                                    ? Theme.of(context)
                                                        .primaryTextTheme
                                                        .subtitle1
                                                    : Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){

                                        chat.type == "image" ?  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatImage(
                                          imageUrl: chat.message ,
                                          currentUserId: widget.currentUserId,
                                        ))):
                                        print('tapped');

                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: chat.type == "text"
                                            ? Text(
                                                chat.message!,
                                                maxLines: 50,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection: TextDirection.ltr,
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText2,
                                              )
                                            : Image.network(chat.message!),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              chatTime.hour > 0 && chatTime.hour < 12
                                  ? '${chatTime.hour.toString()}:${chatTime.minute.toString()} AM '
                                  : '${chatTime.hour.toString()}:${chatTime.minute.toString()} PM ',
                              style:
                                  Theme.of(context).primaryTextTheme.overline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget chatUi(BuildContext context, snapshot, User thisUser) {
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
          endDrawer: DrawerMenuWidget(
            currentUserId: widget.currentUserId,
            matchedUserData: widget.matchedUserData,
            a: widget.analytics,
            o: widget.observer,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Stack(
              children: [
                ListView(
                  controller: _listScrollController,
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.25),
                        child: messageList())
                  ],
                ),
                ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: g.isRTL
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                width: MediaQuery.of(context).size.width,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.more_vert,
                                    size: 28,
                                  ),
                                  color: Theme.of(context).iconTheme.color,
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: g.isRTL
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffD6376E),
                                      Color(0xFFAD45B3)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width / 1.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: IconButton(
                                  icon: Icon(FontAwesomeIcons.longArrowAltLeft),
                                  color: Colors.white,
                                  onPressed: () {
                                    g.isDarkModeEnable
                                        ? Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavigationWidgetDark(
                                                      currentUserId:
                                                          widget.currentUserId,
                                                      currentIndex: 2,
                                                      a: widget.analytics,
                                                      o: widget.observer,
                                                    )))
                                        : Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavigationWidgetLight(
                                                      currentUserId:
                                                          widget.currentUserId,
                                                      currentIndex: 2,
                                                      a: widget.analytics,
                                                      o: widget.observer,
                                                    )));
                                  },
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: usersRef
                                  .doc(widget.matchedUserData!.id!)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                User thisUser = User.fromDoc(snapshot.data);
                                return Positioned(
                                  top: 50,
                                  child: CircleAvatar(
                                    radius: 57,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 55,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        thisUser.profileImageUrl!,
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: usersRef
                              .doc(widget.matchedUserData!.id!)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            User thisUser = User.fromDoc(snapshot.data);
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  thisUser.name!,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline3,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, bottom: 6),
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor:
                                        thisUser.onlineOffline! == true
                                            ? Colors.lightGreenAccent[400]
                                            : Colors.redAccent[400],
                                  ),
                                )
                              ],
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // IconButton(
                            //   icon: Image.asset(
                            //     'assets/images/chat icon.png',
                            //     height: 30,
                            //   ),
                            //   color: Theme.of(context).iconTheme.color,
                            //   onPressed: () {},
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 8),
                            //   child: IconButton(
                            //     icon: ShaderMask(
                            //         blendMode: BlendMode.srcIn,
                            //         shaderCallback: (Rect bounds) {
                            //           return LinearGradient(
                            //             colors: [
                            //               Color(0xFFFA809D),
                            //               Color(0xFFFB2205E)
                            //             ],
                            //             begin: Alignment.centerLeft,
                            //             end: Alignment.centerRight,
                            //           ).createShader(bounds);
                            //         },
                            //         child: Icon(FontAwesomeIcons.video)),
                            //     color: Theme.of(context).iconTheme.color,
                            //     onPressed: () {
                            //       Navigator.of(context).push(MaterialPageRoute(
                            //           builder: (context) => VideoCallingScreen(
                            //                 a: widget.analytics,
                            //                 o: widget.observer,
                            //               )));
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: BottomAppBar(
            color: g.isDarkModeEnable
                ? Color(0xFF14012F)
                : Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextField(
                    focusNode: myFocusNode,
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                    controller: _cMessage,
                    decoration: InputDecoration(
                      contentPadding: g.isRTL
                          ? EdgeInsets.only(right: 20)
                          : EdgeInsets.only(left: 20),
                      hintText: "Type Message",
                      hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                ),
                Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TabBar(
                    controller: _tabController,
                    indicatorWeight: 3,
                    indicatorColor: Theme.of(context).primaryColorLight,
                    labelColor: Theme.of(context).iconTheme.color,
                    unselectedLabelColor: Theme.of(context).primaryColorLight,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.only(bottom: 65),
                    labelPadding: EdgeInsets.all(0),
                    onTap: (int index) async {
                      _currentIndex = index;
                      setState(() {});
                    },
                    tabs: [
                      Tab(
                        child: GestureDetector(
                          onTap: () async {
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              _listScrollController!.animateTo(
                                _listScrollController!.position.maxScrollExtent,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            });

                            if (_cMessage.text.isNotEmpty &&
                                _cMessage.text.length > 0)
                              await DatabaseService.sendMessages(
                                      widget.currentUserId!,
                                      widget.matchedUserData!.id!,
                                      _cMessage.text.toString(),
                                      thisUser)
                                  .whenComplete(() {
                                setState(() {
                                  _cMessage.clear();
                                });
                              });
                          },
                          child: Icon(
                            Icons.send,
                            size: 20,
                          ),
                        ),
                      ),
                      // Tab(
                      //   child: Icon(
                      //     MdiIcons.emoticonHappy,
                      //     size: 20,
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () async {
                          await selectFile(thisUser);
                        },
                        child: Tab(
                          child: Icon(
                            MdiIcons.attachment,
                            size: 20,
                          ),
                        ),
                      ),
                      // Tab(
                      //   child: Icon(
                      //     MdiIcons.microphone,
                      //     size: 20,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UploadTask? task;
  File? file;

  Future selectFile(User thisUser) async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));

    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    await DatabaseService.sendMessagesImage(widget.currentUserId!,
            widget.matchedUserData!.id!, urlDownload.toString(), thisUser)
        .whenComplete(() {
      setState(() {
        _cMessage.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: usersRef.doc(widget.currentUserId).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
        User thisUser = User.fromDoc(snapshot.data);
        return chatUi(context, snapshot, thisUser);
      },
    );
  }

  Timer? time;

  @override
  void initState() {
    super.initState();

    _tabController =
        new TabController(length: 2, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => {
          _listScrollController!
              .jumpTo(_listScrollController!.position.maxScrollExtent)
        });
    //  _listScrollController!.jumpTo(_listScrollController!.position.maxScrollExtent);
    //_listScrollController2!.jumpTo(_listScrollController2!.position.maxScrollExtent);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode!.dispose();

    super.dispose();
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }
}
