import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' hide context;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_dating/api/firebase_api.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/likes&IntrestScreen.dart';
import 'package:flutter/material.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/screens/splashScreen.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

class StartUpEditProfilePage extends BaseRoute {
  final String? currentUserId;
  final User? thisProfileUser;

  StartUpEditProfilePage({a, o, this.currentUserId,this.thisProfileUser})
      : super(a: a, o: o, r: 'ProfileDetailScreen');

  @override
  _StartUpEditProfilePageState createState() => _StartUpEditProfilePageState();
}

class _StartUpEditProfilePageState extends BaseRouteState {
  TextEditingController _cFirstName = new TextEditingController();
  TextEditingController _cLastName = new TextEditingController();
  TextEditingController _cBDate = new TextEditingController();
  TextEditingController _cBio = new TextEditingController();
  TextEditingController _cPhone = new TextEditingController();

  String? firstName;
  String? phone;
  int? dob;
  String? gender;
  String?  bio;
  User? user;

  String? _gender = 'Select Gender';
  final _formKey = GlobalKey<FormState>();
  XFile? _profileImage;
  String? url;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position? _currentPosition;
  String? _currentAddress;




  var _scaffoldKey = GlobalKey<ScaffoldState>();

  UploadTask? task;
  File? file;

  List<String> filter = [];

  _StartUpEditProfilePageState() : super();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    firstName = widget.thisProfileUser!.name!;
    dob = widget.thisProfileUser!.dob!;
    phone = widget.thisProfileUser!.phoneNumber!;
    bio = widget.thisProfileUser!.bio!;


    //getMatchedChatted();
  }

  _getCurrentLocation()  {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });



      _getAddressFromLatLng();

    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.administrativeArea}";
      });

      print(place.administrativeArea);
    } catch (e) {
      print(e);
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    filter.clear();
    filter.add(dob.toString());
    filter.add(_gender.toString());
    filter.add(_currentAddress!);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:
      Theme.of(context).primaryColorLight,

      content: Text("Checking if you are up to date"),
      //  backgroundColor: Colors.black,
    ));


  // if   (widget.thisProfileUser!.profileImageUrl == null || widget.thisProfileUser!.profileImageUrl == '' )
  //
  //   {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       backgroundColor:
  //       Theme.of(context).primaryColorLight,
  //
  //       content: Text("please update your profile picture to proceed"),
  //       //  backgroundColor: Colors.black,
  //     ));
  //     return;
  //   }


    if (file == null && (widget.thisProfileUser!.profileImageUrl == null || widget.thisProfileUser!.profileImageUrl!.length < 4)  ) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:
        Theme.of(context).primaryColorLight,

        content: Text("please add your profle image "),
        //  backgroundColor: Colors.black,
      ));

      return;
      // await usersRef.doc(widget.currentUserId.toString()).update({
      //   'name': firstName.toString(),
      //   'phoneNumber': phone.toString(),
      //   'dob': int.tryParse(dob.toString()),
      //   'gender': _gender.toString(),
      //   'bio': bio.toString(),
      //   //   'profileImageUrl': urlDownload,
      //   //  'intrests': FieldValue.arrayUnion(filter),
      //   'filters': FieldValue.arrayUnion(filter),
      //
      // });

      // print('Download-Link: $urlDownload');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:
        Theme.of(context).primaryColorLight,

        content: Text("Profile Updated"),
        //  backgroundColor: Colors.black,
      ));

      Navigator.pop(context);

    }

    if (file != null  && (widget.thisProfileUser!.profileImageUrl == null  || widget.thisProfileUser!.profileImageUrl!.length < 4))
      {
        final fileName = basename(file!.path);
        final destination = 'files/$fileName';

        task = FirebaseApi.uploadFile(destination, file!);
        setState(() {});

        if (task == null) return;

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        url = urlDownload;

        // User user = User(
        //   name: _cFirstName.text.toString(),
        //   phoneNumber: phone,
        //   profileImageUrl: url,
        //   dob: dob,
        //   gender: _gender,
        // );
        // Database update

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:
          Theme.of(context).primaryColorLight,

          content: Text("please wait while we update your profile"),
          //  backgroundColor: Colors.black,
        ));


        await usersRef.doc(widget.currentUserId.toString()).update({
          'name': firstName.toString(),
          'phoneNumber': phone.toString(),
          'dob': int.tryParse(dob.toString()),
          'gender': _gender.toString(),
          'bio': bio.toString(),
          'profileImageUrl': urlDownload,
          'filters': FieldValue.arrayUnion(filter),

        });

        print('Download-Link: $urlDownload');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:
          Theme.of(context).primaryColorLight,

          content: Text("Profile Updated"),
          //  backgroundColor: Colors.black,
        ));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LikesIntrestScreen(
              currentUserId: widget.currentUserId,
              a: widget.analytics,
              o: widget.observer,
            )));

        // Navigator.pop(context);
      }

    if (file == null  && (widget.thisProfileUser!.profileImageUrl != null || widget.thisProfileUser!.profileImageUrl!.length > 4))
    {


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:
        Theme.of(context).primaryColorLight,

        content: Text("please wait while we update your profile"),
        //  backgroundColor: Colors.black,
      ));


      await usersRef.doc(widget.currentUserId.toString()).update({
        'name': firstName.toString(),
        'phoneNumber': phone.toString(),
        'dob': int.tryParse(dob.toString()),
        'gender': _gender.toString(),
        'bio': bio.toString(),
        'profileImageUrl': widget.thisProfileUser!.profileImageUrl,
        'filters': FieldValue.arrayUnion(filter),

      });


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:
        Theme.of(context).primaryColorLight,

        content: Text("Profile Updated"),
        //  backgroundColor: Colors.black,
      ));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LikesIntrestScreen(
            currentUserId: widget.currentUserId,
            a: widget.analytics,
            o: widget.observer,
          )));

      // Navigator.pop(context);
    }



  }

  _handleImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    }
  }

  Widget ui (BuildContext context, AsyncSnapshot snapshot, thisUser){
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Form(
                key: _formKey,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  shrinkWrap: true,

                  //      mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
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
                              file == null
                                  ? CircleAvatar(
                                radius: 63,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundImage: widget.thisProfileUser!.profileImageUrl == null || widget.thisProfileUser!.profileImageUrl!.isEmpty ?  NetworkImage(
                                      'https://www.clipartkey.com/mpngs/m/326-3260960_male-shadow-fill-circle-comments-default-profile-pic.png') :
                                  NetworkImage(widget.thisProfileUser!.profileImageUrl!),
                                  radius: 60,
                                  backgroundColor: Color(0xFF33196B),
                                ),
                              )
                                  : CircleAvatar(
                                  radius: 63,
                                  backgroundColor: Colors.white,
                                  child: Image(
                                    image: FileImage(file!),
                                  )),
                              Positioned(
                                top: 96,
                                left: 96,
                                child: GestureDetector(
                                  onTap: selectFile,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      border: g.isDarkModeEnable
                                          ? Border.all(color: Colors.black)
                                          : null,
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
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.all(1.2),
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                      _currentAddress == null ? 'location' :   "${_currentAddress!}"
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await _getCurrentLocation();

                                    },
                                    child: Icon(
                                      Icons.place,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
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
                          color: g.isDarkModeEnable
                              ? Colors.black
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          initialValue: firstName,
                          autofocus: true,
                        //  focusNode: FocusScopeNode(),
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                          //  controller: _cFirstName,
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle:
                            Theme.of(context).primaryTextTheme.subtitle2,
                            contentPadding: g.isRTL
                                ? EdgeInsets.only(right: 20)
                                : EdgeInsets.only(left: 20),
                          ),
                          onSaved: (input) => firstName = input,
                          onChanged: (input) => firstName = input,

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
                          color: g.isDarkModeEnable
                              ? Colors.black
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          initialValue: bio,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                          //    controller: _cBio,
                          //autofocus: true,
                          //focusNode: FocusScopeNode(),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: "Bio",
                            labelStyle:
                            Theme.of(context).primaryTextTheme.subtitle2,
                            contentPadding: g.isRTL
                                ? EdgeInsets.only(right: 20)
                                : EdgeInsets.only(left: 20),
                          ),
                          onSaved: (input) => bio = input,
                          onChanged: (input) => bio = input,

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
                          color: g.isDarkModeEnable
                              ? Colors.black
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          initialValue: phone,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                          //    controller: _cPhone,
                        //  autofocus: true,
                          //focusNode: FocusScopeNode(),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            labelStyle:
                            Theme.of(context).primaryTextTheme.subtitle2,
                            contentPadding: g.isRTL
                                ? EdgeInsets.only(right: 20)
                                : EdgeInsets.only(left: 20),
                          ),
                          onSaved: (input) => phone = input,
                          onChanged: (input) => phone = input,
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
                          color: g.isDarkModeEnable
                              ? Colors.black
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          initialValue:'${dob.toString()}',
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                          //    controller: _cBDate,
                      //    autofocus: true,
                          //focusNode: FocusScopeNode(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Age",

                              labelStyle: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle2,
                              contentPadding: g.isRTL
                                  ? EdgeInsets.only(right: 20)
                                  : EdgeInsets.only(left: 20),
                              suffixIcon: Padding(
                                padding: g.isRTL
                                    ? const EdgeInsets.only(left: 4)
                                    : const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 20,
                                ),
                              )),
                          onSaved: (input) =>
                          dob = int.tryParse(input.toString())!.toInt(),
                          onChanged: (input) =>
                          dob = int.tryParse(input.toString())!.toInt(),
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
                          color: g.isDarkModeEnable
                              ? Colors.black
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Theme.of(context).primaryColorLight,
                          icon: Padding(
                            padding: g.isRTL
                                ? EdgeInsets.only(left: 20)
                                : EdgeInsets.only(right: 20),
                            child: Icon(Icons.expand_more,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          value: _gender,
                          items: ['Select Gender', 'Female', 'Male']
                              .map((label) => DropdownMenuItem(
                            child: Padding(
                              padding: g.isRTL
                                  ? EdgeInsets.only(right: 20)
                                  : EdgeInsets.only(left: 20),
                              child: Text(
                                label.toString(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                            ),
                            value: label,
                          ))
                              .toList(),
                          hint: Padding(
                            padding: g.isRTL
                                ? EdgeInsets.only(right: 20)
                                : EdgeInsets.only(left: 20),
                            child: Text((_gender!.isEmpty
                                ? "Select Gender"
                                : _gender)!),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
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
                            onPressed: uploadFile,
                            child: Text(
                              "Update",
                              style: Theme.of(context)
                                  .textButtonTheme
                                  .style!
                                  .textStyle!
                                  .resolve({
                                MaterialState.pressed,
                              }),
                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
}
