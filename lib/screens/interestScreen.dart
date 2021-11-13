import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/database_codes/database.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/startConversionScreen.dart';
import 'package:uni_dating/screens/startSwippingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'chatImageScreen.dart';

class IntrestScreen extends BaseRoute {
  final User2? datingUser;
  final String? currentUserId;
  final User? thisProfileUser;
  IntrestScreen({a, o, this.datingUser,this.currentUserId,this.thisProfileUser}) : super(a: a, o: o, r: 'IntrestScreen');
  @override
  _IntrestScreenState createState() => _IntrestScreenState();
}

class _IntrestScreenState extends BaseRouteState {
  late AnimationController controller;
  int _currentIndex = 0;
  late TabController _tabController;
  User2? _newLover;
  final List<String> imgList = [
    'assets/images/profile_img_0.png',
    'assets/images/profile_img_1.png',
    'assets/images/profile_img_2.png',
    'assets/images/profile_img_3.png',
    'assets/images/profile_img_0.png',
  ];
  _IntrestScreenState() : super();

  Future showDoneDialog(User thisUser) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/heartbeat.json',
                    //  'https://assets6.lottiefiles.com/packages/lf20_ZKUJ2j.json',

                    height: 200,
                    width: 200,
                    repeat: false,
                    controller: controller, onLoaded: (composition) {
                      controller.duration = composition.duration;
                      controller.forward();

                      usersRef.doc(widget.datingUser!.id!).update({
                        'like': FieldValue.increment(1),
                      }).then((_) {
                        usersRef.doc(widget.datingUser!.id!).collection("notification").add({
                          'id':widget.currentUserId ,
                          'profileImage': thisUser.profileImageUrl ,
                          'text': 'Just liked your profile',
                          'seen': false,
                          'type': 'like',
                          'name': thisUser.name,
                          'timestamp': Timestamp.now().toDate().toLocal(),

                        });
                      });
                    }),
              ],
            ),
          ),
        ));
  }

  Widget ui (BuildContext context, AsyncSnapshot snapshot, User thisUser)
  {
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  StreamBuilder<DocumentSnapshot>(
                      stream: usersRef.doc(_newLover == null || _newLover!.id == null  ? '${widget.datingUser!.id}':
                      _newLover!.id!).snapshots(),
                      builder: (context,AsyncSnapshot snapshot) {

                        if(!snapshot.hasData)
                        {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        User _user = User.fromDoc(snapshot.data);
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          child: Image.network(
                            _user.profileImageUrl == null  ? '':
                            _user.profileImageUrl!,
                            fit: BoxFit.contain,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(19, 1, 51, 1),
                          ),
                        ),
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFF130032),
                        child: IconButton(
                          icon: Icon(MdiIcons.messageReplyTextOutline),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StartConversionScreen(
                                  currentUserId: widget.currentUserId,
                                  matchedUserData: widget.datingUser,
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                          },
                        )),
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 8),
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width,
                    color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width / 1.9,
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
                      StreamBuilder<DocumentSnapshot>(
                        stream: usersRef.doc(_newLover == null || _newLover!.id == null  ? '${widget.datingUser!.id}':
                        _newLover!.id!).snapshots(),
                        builder: (context,AsyncSnapshot snapshot) {

                          if(!snapshot.hasData)
                            {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          User _user = User.fromDoc(snapshot.data);

                          return ListTile(
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
                                       _user.name == null  ? '':
                                      _user.name!,
                                      style: Theme.of(context).primaryTextTheme.headline1,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 30,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.thumb_up_alt_outlined,
                                              color: Theme.of(context).iconTheme.color,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4),
                                              child: Text(
                                                _user.like == null  ? '':
                                                _user.like!.toString(),
                                                style: Theme.of(context).primaryTextTheme.bodyText1,
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
                                              color: Theme.of(context).iconTheme.color,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4),
                                              child: Text(
                                                _user.love == null  ? '':
                                                _user.love!.toString(),
                                                style: Theme.of(context).primaryTextTheme.bodyText1,
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
                                      showDoneDialog(thisUser);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          gradient: LinearGradient(
                                            colors: [Colors.green[200]!, Colors.green[900]!],
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
                                  InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Starting to Dislike this person"),
                                        backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                        duration: Duration(seconds: 1),
                                      ));

                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          gradient: LinearGradient(
                                            colors: [Colors.red[200]!, Colors.pink[700]!],
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
                          );
                        }
                      ),
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          "Hello Friends!",
                          style: Theme.of(context).primaryTextTheme.headline3,
                        ),
                      ),
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 10) : const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          _newLover == null || _newLover!.bio == null  ? '':
                          _newLover!.bio!,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: Theme.of(context).iconTheme.color,
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
                        height: (MediaQuery.of(context).size.height * 0.12),
                        width: MediaQuery.of(context).size.width,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                          _newLover == null || _newLover!.id == null ? SizedBox.shrink():  StreamBuilder(
                                stream: DatabaseService.getProfilePosts(_newLover!.id!),
                                builder: (context,AsyncSnapshot snapshot) {
                                  final List<ImagePost>? post = snapshot.data;
                                  if (snapshot.data == null || !snapshot.hasData) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  return GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: MediaQuery.of(context).size.width,
                                      mainAxisSpacing: 2.0,
                                      crossAxisSpacing: 2.0,
                                    ),
                                    itemCount: post!.length,
                                    itemBuilder: (ctx, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatImage(
                                            imageUrl: post[index].image!,
                                            currentUserId: widget.currentUserId,
                                          )));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.white),
                                            color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                          ),
                                          height: (MediaQuery.of(context).size.height * 0.12),
                                          width: MediaQuery.of(context).size.width,
                                          child: GridTile(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.network(
                                                post[index].image!,
                                                height: (MediaQuery.of(context).size.height * 0.12),
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                            ),
                            Container(),

                          ],
                        ),
                      ),
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          "Intrests",
                          style: Theme.of(context).primaryTextTheme.headline3,
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
                              itemCount: _newLover == null || _newLover!.intrests == null ? 0 :  _newLover!.intrests!.length,
                              itemBuilder: (BuildContext context, index){
                                List<String> _intrests = [];

                                _intrests..addAll(_newLover!.intrests!);
                                print(_intrests);

                                return  Padding(
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
                                          style: Theme.of(context).accentTextTheme.subtitle2,
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

    controller = AnimationController(vsync: this);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
    _tabController = new TabController(length: 2, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
    _getNewDaters();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
   _getNewDaters() async {
     User2 newLover =   await DatabaseService.getNewLoverWithId(widget.datingUser!);
   setState(() {
     _newLover = newLover ;
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
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFCC3263),
            width: MediaQuery.of(context).size.width / 1.9,
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
