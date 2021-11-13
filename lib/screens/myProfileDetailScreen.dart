import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_dating/api/firebase_api.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/database_codes/database.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/chatImageScreen.dart';
import 'package:uni_dating/screens/edit_profile.dart';
import 'package:uni_dating/screens/loginScreen.dart';
import 'package:uni_dating/screens/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart' hide context;
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

import '../main.dart';

class MyProfileSceen extends BaseRoute {
  final String? currentUserId;

  MyProfileSceen({a, o, this.currentUserId})
      : super(a: a, o: o, r: 'MyProfileSceen');

  @override
  _MyProfileSceenState createState() => _MyProfileSceenState();
}

class _MyProfileSceenState extends BaseRouteState {
  final user = FirebaseAuth.instance.currentUser!;
  String? url;
  UploadTask? task;
  File? file;
  int _currentIndex = 0;
  late TabController _tabController;
  final googleSignIn = GoogleSignIn();

  _MyProfileSceenState() : super();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    url = urlDownload;

    // User user = User(
    //
    //   name:  _cFirstName.text.toString(),
    //   phoneNumber: phone,
    //   profileImageUrl: url,
    //   dob: dob,
    //   gender: _gender,
    //
    //
    // );
    // // Database update
    // await  usersRef.doc(widget.currentUserId.toString()).update({
    //   'name': _cFirstName.text.toString() ,
    //   'phoneNumber': phone ,
    //   'dob': dob ,
    //   'gender': gender ,
    // });

    print('Download-Link: $urlDownload');
  }

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

  Widget profileUi (BuildContext context,AsyncSnapshot snapshot,User thisUser)
  {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
            appBar: _appBarWidget(user.uid, thisUser),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Container(
                        // child: Image.asset(
                        //   'assets/images/profile.png',
                        //   fit: BoxFit.cover,
                        // ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image:
                              CachedNetworkImageProvider(thisUser.profileImageUrl!)),
                          color: Color.fromRGBO(19, 1, 51, 1),
                        ),
                      ),
                    ),
                    Container(
                      color:
                      g.isDarkModeEnable ? Color(0xFF130032) : Colors.white,
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    // await FirebaseAuth.instance.signOut();
                                    // await googleSignIn.signOut();
                                    // Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => MyApp()),
                                    //         (route) => false);
                                  },
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: g.isDarkModeEnable
                                        ? Theme.of(context).iconTheme.color
                                        : Theme.of(context).primaryColorLight,
                                    size: 18,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Container(
                                    child: Text(
                                        thisUser.love! >= 1000 ?  '${thisUser.love.toString()}k' : '${thisUser.love.toString()}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: g.isDarkModeEnable
                                ? Color(0xFF230f4E)
                                : Colors.purple[100],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: g.isDarkModeEnable
                                      ? Theme.of(context).iconTheme.color
                                      : Theme.of(context).primaryColorLight,
                                  size: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Container(
                                    child: Text(
                                        thisUser.like! > 1000 ?  '${thisUser.like.toString()}k' : '${thisUser.like.toString()}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: g.isDarkModeEnable
                                ? Color(0xFF230f4E)
                                : Colors.purple[100],
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NotificationListScreen(
                                      currentUserId: widget.currentUserId,
                                      thisProfileUser: thisUser,
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.comment_outlined,
                                    color: g.isDarkModeEnable
                                        ? Theme.of(context).iconTheme.color
                                        : Theme.of(context).primaryColorLight,
                                    size: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: usersRef.doc(widget.currentUserId).collection("secreteMessages").snapshots(),
                                      builder: (context, snapshot) {


                                        int _length = 0;
                                        if (snapshot.connectionState == ConnectionState.active)
                                          {
                                            List _documents = snapshot.data!.docs;
                                            _length =  _documents.length;
                                          }

                                        return Text(
                                         _length > 1000 ? '${_length.toString()}K' : _length > 1000000 ?  '${_length.toString()}M' : '$_length',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                        );
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: g.isDarkModeEnable
                                ? Color(0xFF230f4E)
                                : Colors.purple[100],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue[900]!,
                                  Colors.blueAccent[700]!
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostUpload(
                                          currentUserId:
                                          user.uid.toString(),
                                        )));
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfilePage(
                                //   a: widget.analytics,
                                //   o: widget.observer,
                                //   currentUserId: user.uid.toString(),
                                // )));
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 20,
                                child: Icon(
                                  Icons.camera,
                                  //   Icons.border_color_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width,
                      color: g.isDarkModeEnable
                          ? Color(0xFF130032)
                          : Theme.of(context).scaffoldBackgroundColor,
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      color: Color(0xFFAD45B3),
                      width: MediaQuery.of(context).size.width / 2 - 35,
                      height: 15,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              "${thisUser.name!}",
                              style:
                              Theme.of(context).primaryTextTheme.headline1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: g.isRTL
                              ? const EdgeInsets.only(right: 20)
                              : const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        thisUser.phoneNumber == null
                                            ? " "
                                            : '${thisUser.phoneNumber}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 30,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.mail,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        '${user.email!}',
                                        style: Theme.of(context)
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
                        Padding(
                          padding: g.isRTL
                              ? const EdgeInsets.only(right: 20, top: 30)
                              : const EdgeInsets.only(left: 20, top: 30),
                          child: Text(
                            "Short Bio",
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL
                              ? const EdgeInsets.only(right: 20, top: 10)
                              : const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            '${thisUser.bio}',maxLines: 10,textDirection: TextDirection.ltr,softWrap: true,overflow: TextOverflow.fade,
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
                                    "My Bio",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              )
                                  : Text(
                                "My Bio",
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
                              StreamBuilder(
                                  stream: DatabaseService.getProfilePosts(user.uid),
                                  builder: (context,AsyncSnapshot snapshot) {
                                    final List<ImagePost>? post = snapshot.data;
                                    if (snapshot.data == null || !snapshot.hasData) {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                    return GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                        MediaQuery.of(context).size.width,
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
                                            margin: EdgeInsets.only(top: 20, left: 20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.white),
                                              color: g.isDarkModeEnable
                                                  ? Color(0xFF1D0529)
                                                  : Colors.white54,
                                            ),
                                            height:
                                            (MediaQuery.of(context).size.height *
                                                0.12),
                                            width: MediaQuery.of(context).size.width,
                                            child: GridTile(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(19),
                                                child: Image.network(
                                                  post[index].image!,
                                                  height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.12),
                                                  width:
                                                  MediaQuery.of(context).size.width,
                                                  fit: BoxFit.cover,
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
                          padding: g.isRTL
                              ? const EdgeInsets.only(right: 20, top: 30)
                              : const EdgeInsets.only(left: 20, top: 30),
                          child: Text(
                            "Intrests",
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 50.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: StreamBuilder(
                                    stream: DatabaseService.getUserInterestOnProfile(user.uid) ,
                                    builder: (context,AsyncSnapshot snapshot){
                                      final List<User>? user = snapshot.data;
                                      if (snapshot.data == null || !snapshot.hasData) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      return  ListView.builder(
                                          shrinkWrap: false,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: user!.length,

                                          itemBuilder: (ctx, index){
                                            return Padding(
                                              padding: g.isRTL
                                                  ? EdgeInsets.only(right: 20, top: 20)
                                                  : EdgeInsets.only(left: 20, top: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    MdiIcons.heart,
                                                    color: Color(0xFFB783EB),
                                                    size: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      "${user[index].intrests}",
                                                      style: Theme.of(context)
                                                          .accentTextTheme
                                                          .subtitle2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },

                                  ),
                                ),

                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return  FutureBuilder<DocumentSnapshot>(
      future: usersRef.doc(user.uid).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
        User thisUser = User.fromDoc(snapshot.data);
        return profileUi(context, snapshot, thisUser);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(length: 2, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  PreferredSizeWidget _appBarWidget(String userId, User thisUser) {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: g.isRTL ? Alignment.centerLeft : Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            color: g.isDarkModeEnable
                ? Color(0xFF130032)
                : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingScreen(
                      thisProfileUser: thisUser,
                      currentUserId: userId,
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFDC3664),
            width: MediaQuery.of(context).size.width / 2 - 35,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
             //   Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PostUpload extends StatefulWidget {
  final String? currentUserId;

  PostUpload({this.currentUserId});

  @override
  _PostUploadState createState() => _PostUploadState();
}

class _PostUploadState extends State<PostUpload> {
  String? url;
  UploadTask? task;
  File? file;
  bool? isLoading = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {

    setState(() {
      isLoading = true;
    });

    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    url = urlDownload;

    setState(() {
      file = null;


    });

    // User user = User(
    //
    //   name:  _cFirstName.text.toString(),
    //   phoneNumber: phone,
    //   profileImageUrl: url,
    //   dob: dob,
    //   gender: _gender,
    //
    //
    // );
    // // Database update
    await  usersRef.doc(widget.currentUserId.toString()).collection("ImagePost").add({
      'image': urlDownload,
      'id': widget.currentUserId,
    });
    setState(() {
      isLoading = false;
    });

    print('Download-Link: $urlDownload');
    Navigator.pop(context);
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: g.isRTL ? Alignment.centerLeft : Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            color: g.isDarkModeEnable
                ? Color(0xFF130032)
                : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: isLoading == false ? IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).iconTheme.color,
              onPressed: uploadFile,
            ):
            CircularProgressIndicator(),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFDC3664),
            width: MediaQuery.of(context).size.width / 2 - 35,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);

              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: _appBarWidget(),
        body: GestureDetector(
          onTap: selectFile,
          child: Container(
            height: height,
            width: width,
            child: file == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                        size: 150.0,
                      ),
                      Text(" Tap to post")
                    ],
                  )
                : Image(
                    image: FileImage(file!),
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}


class NotificationListScreen extends BaseRoute {
  final User? thisProfileUser;
  final String? currentUserId;

  NotificationListScreen({a, o, this.thisProfileUser, this.currentUserId})
      : super(a: a, o: o, r: 'NotificationListScreen');

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _NotificationListScreenState() : super();

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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Secret Comments",
                  style: Theme.of(context).primaryTextTheme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 20),
                  child: Text(
                    "See anonymous comments, ",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: DatabaseService.anonymousComment(
                          widget.currentUserId!),
                      builder: (context, AsyncSnapshot snapshot) {
                        final List<AnonymousComment>? notificationList =
                            snapshot.data;
                        if (snapshot.data == null || !snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemCount: notificationList!.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: (){

                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 31,
                                          child: CircleAvatar(
                                            backgroundImage:
                                            CachedNetworkImageProvider(
                                              notificationList[index]
                                                  .profileImage!,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: g.isRTL
                                              ? const EdgeInsets.only(right: 12)
                                              : const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notificationList[index].name!,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4, bottom: 4),
                                                child: Text(
                                                  notificationList[index].message!,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                              Text(
                                                "${notificationList[index].timestamp!.toDate().day.toString()}|${notificationList[index].timestamp!.toDate().month.toString()}|${notificationList[index].timestamp!.toDate().year.toString()}",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle2,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12, bottom: 12),
                                    height: 1.5,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: g.gradientColors,
                                      ),
                                    ),
                                    child: Divider(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
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

