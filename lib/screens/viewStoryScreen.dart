

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;

class ViewStoryScreen extends BaseRoute {
  final StatusPost? statusPost;
  final String? currentUserId;
  final String? userStoryId;

  ViewStoryScreen({a, o, this.statusPost, this.currentUserId, this.userStoryId})
      : super(a: a, o: o, r: 'ViewStoryScreen');

  @override
  _ViewStoryScreenState createState() => new _ViewStoryScreenState();
}

class _ViewStoryScreenState extends BaseRouteState {
  List<StoryItem> storyItems = [
    new StoryItem.pageProviderImage(
      AssetImage(
        'assets/images/view1.png',
      ),
      imageFit: BoxFit.fitWidth,
      duration: Duration(seconds: 30),
    ),
    new StoryItem.pageProviderImage(
      AssetImage(
        'assets/images/view2.png',
      ),
      imageFit: BoxFit.fitWidth,
      duration: Duration(seconds: 30),
    ),
    new StoryItem.pageProviderImage(
      AssetImage(
        'assets/images/view3.png',
      ),
      imageFit: BoxFit.fitWidth,
      duration: Duration(seconds: 30),
    ),
  ];

  _ViewStoryScreenState() : super();

  Widget ui(BuildContext context) {
    return SafeArea(
      top: true,
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
            backgroundColor: g.isDarkModeEnable
                ? Color(0xFF03000C)
                : Theme.of(context).scaffoldBackgroundColor,
            body: StreamBuilder(
                stream: usersRef
                    .doc(widget.currentUserId!)
                    .collection("StatusPost")
                    .doc(widget.userStoryId!.toString())
                    .collection("status").orderBy('timestamp',descending: true)
                    .snapshots()
                    .map((snapshot) => snapshot.docs
                        .map((doc) => StatusPost.fromDoc(doc))
                        .toList()),
                builder: (context, AsyncSnapshot snapshot) {
                  List<StatusPost>? _status = snapshot.data;
                  if (!snapshot.hasData) {
                    Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return SafeArea(
                    top: true,
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: _status == null ? 0 :  _status.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            StatusPost _statusPost = _status![index];
                            return _statusPost.type == "image"
                                ? Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                _statusPost.text!))),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: g.gradientColors,
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _statusPost.text!,
                                        maxLines: 7,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ),
                                  );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(

                            children: [
                              IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: ()=> Navigator.pop(context)),
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(

                                    _status == null ? '' : _status[0].profileImage!),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      _status == null ? '' : _status[0].name!,style: Theme.of(context).accentTextTheme.headline5,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            // bottomSheet: BottomAppBar(
            //   color: g.isDarkModeEnable ? Color(0xFF14012F) : Theme.of(context).scaffoldBackgroundColor,
            //   elevation: 0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: Container(
            //           width: MediaQuery.of(context).size.width * 0.45,
            //           child: TextField(
            //             style: Theme.of(context).primaryTextTheme.subtitle2,
            //             //controller: _cMessage,
            //             decoration: InputDecoration(
            //               contentPadding: EdgeInsets.only(left: 20),
            //               hintText: "Reply",
            //               hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
            //             ),
            //           ),
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.send,
            //           size: 20,
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           MdiIcons.emoticonHappy,
            //           size: 20,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ui(context);
  }

  @override
  void initState() {
    super.initState();
  }
}
