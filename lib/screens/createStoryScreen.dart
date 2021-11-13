import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_dating/api/firebase_api.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/addTextCreateStoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path/path.dart' hide context;

class CreateStoryScreen extends BaseRoute {
  final String? currentUserId;
  final User2? matchedUserData;
  CreateStoryScreen({a, o,this.currentUserId,this.matchedUserData}) : super(a: a, o: o, r: 'CreateStoryScreen');
  @override
  _CreateStoryScreenState createState() => new _CreateStoryScreenState();
}

class _CreateStoryScreenState extends BaseRouteState {
  List<Asset> images = <Asset>[];
  String error = 'No Error Detected';

  _CreateStoryScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null!;
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
            appBar: _appBarWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddTextCreateStory(
                                  currentUserId: widget.currentUserId,
                                      matchedUserData: widget.matchedUserData,
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20, left: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white),
                                gradient: LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Text(
                                    "Aa",
                                    style: Theme.of(context).accentTextTheme.headline1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    "Text",
                                    style: Theme.of(context).accentTextTheme.headline4,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                           // loadAssets();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostUpload(
                                      currentUserId:
                                      widget.currentUserId,
                                    )));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20, left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                              gradient: LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Color(0xFF33196B),
                                    size: 28,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    "Media",
                                    style: Theme.of(context).accentTextTheme.headline4,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  images != null && images.length > 0
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: GridView.count(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 10,
                                crossAxisCount: 3,
                                children: List.generate(images.length, (index) {
                                  Asset asset = images[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white),
                                      color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(19),
                                      child: AssetThumb(
                                        asset: asset,
                                        width: 300,
                                        height: 300,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
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
                      child: Text(
                          "Create",
                          style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                            MaterialState.pressed,
                          })),
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
  void initState() {
    super.initState();
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Text(
              'Create Story',
              style: Theme.of(context).primaryTextTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          autoCloseOnSelectionLimit: false,
          actionBarColor: "#14012E",
          actionBarTitle: "Select",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      //_error = error;
    });
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

  Future uploadFile(User thisUser) async {
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
    await  usersRef
        .doc(widget.currentUserId)
        .collection("Matched")
        .get()
        .then((value) {

      value.docs.forEach((element) async {

        print(element.id.toString());
        print(element.reference.id.toString());
        print(value.docs.toString());

        usersRef
            .doc(element.reference.id.toString())
            .collection("StatusPost").doc(widget.currentUserId).collection("status")
            .add({
          'text': urlDownload,
          'id': widget.currentUserId ,
          'profileImage': thisUser.profileImageUrl,
          'name' : thisUser.name,
          'type': 'image',
          'timestamp': Timestamp.now().toDate().toLocal(),

        });
        print("done");
        print(element.id.toString());
        print(element.reference.id.toString());
        print(value.docs.toString());
      });
    });
    setState((){
      isLoading =  false;
    });

    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text("Status updated"),
      backgroundColor: Theme.of(context).primaryColorLight,
      //  backgroundColor: Colors.black,
    ));



    Navigator.of(context).pop();

    print('Download-Link: $urlDownload');
    Navigator.pop(context);
  }

  PreferredSizeWidget _appBarWidget( User thisUser) {
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
              onPressed: ()=> uploadFile(thisUser),
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
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget createPostUi(BuildContext context, AsyncSnapshot snapshot, User thisUser){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: _appBarWidget(thisUser),
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
        return createPostUi(context, snapshot, thisUser);
      },
    );

  }
}
