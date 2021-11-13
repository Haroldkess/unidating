import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/database_codes/database.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/addYourStoryModel.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/createStoryScreen.dart';
import 'package:uni_dating/screens/filterOptionsScreen.dart';
import 'package:uni_dating/screens/interestScreen.dart';

import 'package:uni_dating/screens/notificationListScreen.dart';
import 'package:uni_dating/screens/selectPlanScreen.dart';
import 'package:uni_dating/screens/viewStoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddYourStoryScreen extends BaseRoute {
  final String? currentUserId;

  AddYourStoryScreen({a, o, this.currentUserId})
      : super(a: a, o: o, r: 'AddYourStoryScreen');

  @override
  _AddYourStoryScreenState createState() => _AddYourStoryScreenState();
}

class _AddYourStoryScreenState extends BaseRouteState {
  int _currentIndex = 0;
  late TabController _tabController;
  List<User3> users = [];

  final List<String> circleImageList = [
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
  ];

  List<AddYourStory> _storyList = [
    new AddYourStory(
        name: 'Belle Benson',
        age: 28,
        km: 1.5,
        imgPath: 'assets/images/card_img_0.png',
        count: 35),
    new AddYourStory(
        name: 'Ruby Diaz',
        age: 33,
        km: 1.2,
        imgPath: 'assets/images/card_img_1.png',
        count: 81),
    new AddYourStory(
        name: 'Myley Corbyon',
        age: 23,
        km: 1.5,
        imgPath: 'assets/images/card_img_2.png',
        count: 49),
    new AddYourStory(
        name: 'Tony Z',
        age: 25,
        km: 2,
        imgPath: 'assets/images/card_img_1.png',
        count: 29),
    new AddYourStory(
        name: 'Ruby Raman',
        age: 30,
        km: 1.6,
        imgPath: 'assets/images/card_img_4.png',
        count: 50),
  ];

  get_uniDatingLikedYouUsers() async {
    //  print("$_intrestsList,   this is my intrest directly from the database");
    List<User3> user =
        await DatabaseService.getLikedMeRequest(widget.currentUserId!);
    setState(() {
      users = user;
    });
    //  print("$_intrestsList,   this is my intrest directly from the database");
  }

  _acceptLikeRequestBottomSheet(
      String userId,
      User thisUser,
      List intrest,
      String name,
      String email,
      String phoneNumber,
      String profileImageUrl,
      bool paid,
      bool onlineStatus) {
    //  User user = User.fromDoc(snapshot.data);
    Size size = MediaQuery.of(context).size;
    double categoryHeight = size.height * 0.30;
    var height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: categoryHeight + 20,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Text(
                        "Accept",
                        style: Theme.of(context).accentTextTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        // style: ButtonStyle(
                        //   backgroundColor:
                        //       MaterialStateProperty.all(Colors.blue),
                        // ),
                        onPressed: () async {
                          await DatabaseService.acceptMatchRequest(
                              widget.currentUserId!,
                              userId,
                              thisUser,
                              intrest,
                              name,
                              email,
                              phoneNumber,
                              profileImageUrl,
                              paid,
                              onlineStatus);

                          await usersRef
                              .doc(userId)
                              .collection("notification")
                              .add({
                            'id': widget.currentUserId,
                            'profileImage': thisUser.profileImageUrl,
                            'text': 'You have a secret message',
                            'seen': false,
                            'type': 'RequestAccepted',
                            'name': thisUser.name,
                            'timestamp': Timestamp.now().toDate().toLocal(),
                          }).then((_) {
                            usersRef.doc(userId).update({
                              'notificationNumber': 1,
                            });
                          });

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            action: SnackBarAction(
                              label: "say Hi",
                              textColor: Theme.of(context).primaryColor,
                              onPressed: () {},
                            ),
                            content: Text("Request accepted"),
                            //  backgroundColor: Colors.black,
                          ));
                        },
                        child: Text(
                          "Accept",
                          style: Theme.of(context).accentTextTheme.headline6,
                        )),
                    TextButton(
                        onPressed: () async {
                          await DatabaseService.deleteMatchRequest(
                              widget.currentUserId!, userId);

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            content: Text("Request dismissed"),
                            //  backgroundColor: Colors.black,
                          ));
                        },
                        child: Text("Reject",
                            style: Theme.of(context).accentTextTheme.subtitle2))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _AddYourStoryScreenState() : super();

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
        onWillPop: () async  {
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
            appBar: _appBarWidget(_thisUser),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: g.isRTL
                        ? const EdgeInsets.only(right: 15)
                        : EdgeInsets.only(left: 10),
                    child: Image.asset(
                      g.isDarkModeEnable
                          ? 'assets/images/swirl arrow.png'
                          : 'assets/images/swirl arrow_light.png',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateStoryScreen(
                                      currentUserId: widget.currentUserId,
                                      matchedUserData: widget.matchedUserData,
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                            //     : Navigator.of(context).push(MaterialPageRoute(
                            // builder: (context) => ViewStoryScreen(
                            // a: widget.analytics,
                            // o: widget.observer,
                            // )));
                          },
                          child: Padding(
                              padding: g.isRTL
                                  ? const EdgeInsets.only(left: 10)
                                  : const EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xFFF1405B),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 50,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: usersRef.doc(widget.currentUserId).collection("StatusPost").snapshots(),
                              builder: (context,  snapshot) {
                                int _length = 0;
                                List? _documents;
                                if (snapshot.connectionState == ConnectionState.active)
                                {
                                   _documents = snapshot.data!.docs;
                                  _length =  _documents.length;
                                }
                                return ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _documents == null ? 0 : _documents.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    return FutureBuilder<DocumentSnapshot>(
                                      future: usersRef.doc(_documents![index].id!).get(),
                                      builder: (context,AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData)
                                          {
                                         return Center(
                                              child: Text("Please wait..."),
                                            );
                                          }
                                        User statusUser = User.fromDoc(snapshot.data);
                                        return GestureDetector(
                                          onTap: () {
                                            print(_documents![index].id!);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewStoryScreen(
                                                          currentUserId: widget.currentUserId,
                                                          userStoryId: _documents![index].id!,
                                                          // statusPost:
                                                          //     statusPost[index],
                                                          a: widget.analytics,
                                                          o: widget.observer,
                                                        )));
                                          },
                                          child: CircleAvatar(
                                            radius: 26,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                              Color(0xFFF1405B),
                                              backgroundImage: NetworkImage(
                                                statusUser.profileImageUrl!,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TabBar(
                      labelPadding: EdgeInsets.only(right: 30),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.only(right: 30),
                      isScrollable: true,
                      controller: _tabController,
                      indicatorColor: Theme.of(context).iconTheme.color,
                      onTap: (int index) async {
                        _currentIndex = index;
                        setState(() {});
                      },
                      tabs: [
                        Tab(text: "All"),
                        Tab(text: "New Daters"),
                        Tab(text: "Liked You"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        StreamBuilder(
                            stream: DatabaseService.matchedAllChat(
                                widget.currentUserId!),
                            builder: (context, AsyncSnapshot snapshot) {
                              final List<User2>? userChatList = snapshot.data;
                              if (snapshot.data == null || !snapshot.hasData) {
                                return Center(
                                    child: Text("users will appear here"));
                              }
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                ),
                                itemCount: userChatList!.length,
                                itemBuilder: (ctx, index) {
                                  return FutureBuilder<DocumentSnapshot>(
                                      future: usersRef
                                          .doc(userChatList[index].id)
                                          .get(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return Scaffold(
                                              body: Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                        }
                                        User thisUser =
                                            User.fromDoc(snapshot.data);
                                        return InkWell(
                                          onTap: () {
                                            _thisUser.paid == true
                                                ? Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            IntrestScreen(
                                                              datingUser:
                                                                  userChatList[
                                                                      index],
                                                              currentUserId: widget
                                                                  .currentUserId,
                                                              a: widget
                                                                  .analytics,
                                                              o: widget
                                                                  .observer,
                                                            )))
                                                : Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SelectPlanScreen(
                                                              currentUserId: widget
                                                                  .currentUserId,
                                                              thisProfileUser:
                                                                  _thisUser,
                                                              a: widget
                                                                  .analytics,
                                                              o: widget
                                                                  .observer,
                                                            )));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white),
                                              color: g.isDarkModeEnable
                                                  ? Color(0xFF1D0529)
                                                  : Colors.white54,
                                            ),
                                            child: GridTile(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  '${thisUser.profileImageUrl}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              header: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor: thisUser
                                                                .onlineOffline ==
                                                            true
                                                        ? Colors
                                                            .lightGreenAccent[400]
                                                        : Colors.redAccent[400],
                                                  ),
                                                ),
                                              ),
                                              footer: ListTile(
                                                contentPadding: EdgeInsets.only(
                                                    left: 12, bottom: 4),
                                                title: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '${thisUser.name}',
                                                        style: Theme.of(context)
                                                            .accentTextTheme
                                                            .headline4,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: g.isRTL
                                                              ? EdgeInsets.only(
                                                                  right: 6)
                                                              : EdgeInsets.all(
                                                                  0),
                                                          child: Text(
                                                            '23 km away',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .headline6,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.camera_alt,
                                                              color:
                                                                  Colors.white,
                                                              size: 14,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 4,
                                                                      right: 8),
                                                              child: Text(
                                                                '++',
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .headline6,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              );
                            }),
                        StreamBuilder(
                            stream: DatabaseService.matchedChatted(
                                widget.currentUserId!),
                            builder: (context, AsyncSnapshot snapshot) {
                              final List<User2>? userChatList = snapshot.data;
                              if (snapshot.data == null || !snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                ),
                                itemCount: userChatList!.length,
                                itemBuilder: (ctx, index) {
                                  return FutureBuilder<DocumentSnapshot>(
                                      future: usersRef
                                          .doc(userChatList[index].id)
                                          .get(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return Scaffold(
                                              body: Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                        }
                                        User thisUser =
                                            User.fromDoc(snapshot.data);
                                        return InkWell(
                                          onTap: () {
                                            _thisUser.paid == true
                                                ? Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            IntrestScreen(
                                                              datingUser:
                                                                  userChatList[
                                                                      index],
                                                              currentUserId: widget
                                                                  .currentUserId,
                                                              a: widget
                                                                  .analytics,
                                                              o: widget
                                                                  .observer,
                                                            )))
                                                : Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SelectPlanScreen(
                                                              currentUserId: widget
                                                                  .currentUserId,
                                                              thisProfileUser:
                                                                  _thisUser,
                                                              a: widget
                                                                  .analytics,
                                                              o: widget
                                                                  .observer,
                                                            )));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white),
                                              color: g.isDarkModeEnable
                                                  ? Color(0xFF1D0529)
                                                  : Colors.white54,
                                            ),
                                            child: GridTile(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  '${thisUser.profileImageUrl}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              header: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor: thisUser
                                                                .onlineOffline ==
                                                            true
                                                        ? Colors
                                                            .lightGreenAccent[400]
                                                        : Colors.redAccent[400],
                                                  ),
                                                ),
                                              ),
                                              footer: ListTile(
                                                contentPadding: EdgeInsets.only(
                                                    left: 12, bottom: 4),
                                                title: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '${thisUser.name}',
                                                        style: Theme.of(context)
                                                            .accentTextTheme
                                                            .headline4,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: g.isRTL
                                                              ? EdgeInsets.only(
                                                                  right: 6)
                                                              : EdgeInsets.all(
                                                                  0),
                                                          child: Text(
                                                            '23 km away',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .headline6,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.camera_alt,
                                                              color:
                                                                  Colors.white,
                                                              size: 14,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 4,
                                                                      right: 8),
                                                              child: Text(
                                                                '++',
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .headline6,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              );
                            }),
                        RefreshIndicator(
                          onRefresh: () => get_uniDatingLikedYouUsers(),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                            ),
                            itemCount: users.length,
                            itemBuilder: (ctx, index) {
                              return FutureBuilder(
                                future:
                                    usersRef.doc(widget.currentUserId).get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return Scaffold(
                                        body: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  }
                                  User thisUser = User.fromDoc(snapshot.data);
                                  return FutureBuilder<DocumentSnapshot>(
                                      future:
                                          usersRef.doc(users[index].id).get(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return Scaffold(
                                              body: Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                        }
                                        User thisUser =
                                            User.fromDoc(snapshot.data);
                                        return InkWell(
                                          onTap: () {
                                            _thisUser.paid == true
                                                ? _acceptLikeRequestBottomSheet(
                                                    users[index].id!,
                                                    thisUser,
                                                    users[index].intrests!,
                                                    users[index].name!,
                                                    users[index].email!,
                                                    users[index].phoneNumber ==
                                                            null
                                                        ? ''
                                                        : users[index]
                                                            .phoneNumber!,
                                                    users[index]
                                                        .profileImageUrl!,
                                                    users[index].paid!,
                                                    users[index].onlineOffline!)
                                                : Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SelectPlanScreen(
                                                              currentUserId: widget
                                                                  .currentUserId,
                                                              thisProfileUser:
                                                                  _thisUser,
                                                              a: widget
                                                                  .analytics,
                                                              o: widget
                                                                  .observer,
                                                            )));
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (context) => IntrestScreen(
                                            //           a: widget.analytics,
                                            //           o: widget.observer,
                                            //         )));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white),
                                              color: g.isDarkModeEnable
                                                  ? Color(0xFF1D0529)
                                                  : Colors.white54,
                                            ),
                                            child: GridTile(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  '${thisUser.profileImageUrl}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              header: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor: thisUser
                                                                .onlineOffline ==
                                                            true
                                                        ? Colors
                                                            .lightGreenAccent[400]
                                                        : Colors.redAccent[400],
                                                  ),
                                                ),
                                              ),
                                              footer: ListTile(
                                                contentPadding: EdgeInsets.only(
                                                    left: 12, bottom: 4),
                                                title: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '${thisUser.name}',
                                                        style: Theme.of(context)
                                                            .accentTextTheme
                                                            .headline4,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // Padding(
                                                        //   padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.all(0),
                                                        //   child: Text(
                                                        //     '${_storyList[index].km} km away',
                                                        //     style: Theme.of(context).primaryTextTheme.headline6,
                                                        //   ),
                                                        // ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.camera_alt,
                                                              color:
                                                                  Colors.white,
                                                              size: 14,
                                                            ),
                                                            // Padding(
                                                            //   padding: EdgeInsets.only(left: 4, right: 8),
                                                            //   child: Text(
                                                            //     '${_storyList[index].count}',
                                                            //     style: Theme.of(context).primaryTextTheme.headline6,
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
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
    _tabController =
        new TabController(length: 3, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
    get_uniDatingLikedYouUsers();
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  PreferredSizeWidget _appBarWidget(User thisUser) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Add Your Story",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: Icon(
                    //     Icons.search,
                    //     color: Theme.of(context).iconTheme.color,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications_rounded),
                            color: Theme.of(context).iconTheme.color,
                            onPressed: () {
                              usersRef.doc(widget.currentUserId!).update({
                                'notificationNumber': 0,
                              });

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotificationListScreen(
                                        currentUserId: widget.currentUserId,
                                        thisProfileUser: thisUser,
                                        a: widget.analytics,
                                        o: widget.observer,
                                      )));
                            },
                          ),
                          thisUser.notificationNumber! > 0
                              ? Positioned(
                                  top: 0.1,
                                  right: 10.1,
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    // IconButton(
                    //   padding: EdgeInsets.all(0),
                    //   icon: Align(
                    //       alignment: Alignment.bottomRight,
                    //       child: (Icon(MdiIcons.tuneVerticalVariant))),
                    //   color: Theme.of(context).iconTheme.color,
                    //   onPressed: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => FilterOptionsScreen(
                    //               a: widget.analytics,
                    //               o: widget.observer,
                    //             )));
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
