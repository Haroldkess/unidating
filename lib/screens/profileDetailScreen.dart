import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/likes&IntrestScreen.dart';
import 'package:flutter/material.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/screens/splashScreen.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

class ProfileDetailScreen extends BaseRoute {
  final String? currentUserId;

  ProfileDetailScreen({a, o, this.currentUserId}) : super(a: a, o: o, r: 'ProfileDetailScreen');
  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends BaseRouteState {
  TextEditingController _cFirstName = new TextEditingController();
  TextEditingController _cLastName = new TextEditingController();
  TextEditingController _cBDate = new TextEditingController();
  String? _gender = 'Select Gender';
  final _formKey = GlobalKey<FormState>();
  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();


  var _scaffoldKey = GlobalKey<ScaffoldState>();


  _ProfileDetailScreenState() : super();


  _handleImageFromGallery(
  ) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,

    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    }
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    if (firstTime != null && !firstTime) {// Not first time
      return Timer(Duration(seconds: 0), () =>   g.isDarkModeEnable
          ? Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavigationWidgetDark(
            currentIndex: 0,
            a: widget.analytics,
            o: widget.observer,
          )))
          : Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavigationWidgetLight(
            currentIndex: 0,
            a: widget.analytics,
            o: widget.observer,
          ))));
    } else {// First time
      prefs.setBool('first_time', false);
      return Timer(Duration(seconds: 0), () => SplashScreen(
        currentUserId: widget.currentUserId,
        a: widget.analytics,
        o: widget.observer,
      )
      );
    }
  }

  _displayProfileImage() {
    // No new profile image
    if (_profileImage == null) {
      // No existing profile image
      if (widget.user!.profileImageUrl!.toString().isEmpty) {
        // Display placeholder
        return AssetImage('assets/images/user_placeholder.jpg');
      } else {
        // User profile image exists
        return CachedNetworkImageProvider(widget.user!.profileImageUrl.toString());
      }
    } else {
      // New profile image
      return FileImage(_profileImage as File);
    }
  }

  Widget profileUi (BuildContext context,AsyncSnapshot snapshot,User thisUser)
  {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return exitAppDialog();
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
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Profile Details",
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "Fill up the following details",
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 63,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/user_placeholder.jpg') ,
                                  radius: 60,
                                  backgroundColor: Color(0xFF33196B),
                                ),
                              ),
                              Positioned(
                                top: 96,
                                left: 96,
                                child: GestureDetector(
                                  onTap: () => _handleImageFromGallery(),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      border: g.isDarkModeEnable ? Border.all(color: Colors.black) : null,
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: g.gradientColors,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 20,
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(1.5),
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 55,
                            child: TextFormField(
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                              controller: _cFirstName,
                              decoration: InputDecoration(
                                labelText:"First Name",
                                labelStyle: Theme.of(context).primaryTextTheme.subtitle2,
                                contentPadding: g.isRTL ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(1.5),
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 55,
                            child: TextFormField(
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                              controller: _cLastName,
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                labelStyle: Theme.of(context).primaryTextTheme.subtitle2,
                                contentPadding: g.isRTL ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(1.5),
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 55,
                            child: TextFormField(
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                              controller: _cBDate,
                              decoration: InputDecoration(
                                  labelText: "DOB",
                                  labelStyle: Theme.of(context).primaryTextTheme.subtitle2,
                                  contentPadding: g.isRTL ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
                                  suffixIcon: Padding(
                                    padding: g.isRTL ? const EdgeInsets.only(left: 4) : const EdgeInsets.only(right: 4),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 20,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(1.5),
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            height: 55,
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Theme.of(context).primaryColorLight,
                              icon: Padding(
                                padding: g.isRTL ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20),
                                child: Icon(Icons.expand_more, color: Theme.of(context).iconTheme.color),
                              ),
                              value: _gender,
                              items: ['Select Gender', 'Women', 'Men']
                                  .map((label) => DropdownMenuItem(
                                child: Padding(
                                  padding: g.isRTL ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
                                  child: Text(
                                    label.toString(),
                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                  ),
                                ),
                                value: label,
                              ))
                                  .toList(),
                              hint: Padding(
                                padding: g.isRTL ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
                                child: Text((_gender!.isEmpty ? "Select Gender" : _gender)!),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LikesIntrestScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                              },
                              child: Text(
                                "Continue",
                                style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                                  MaterialState.pressed,
                                }),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
        return profileUi(context, snapshot, thisUser);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  //  startTime();
  }
}
