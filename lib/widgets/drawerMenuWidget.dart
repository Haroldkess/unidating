
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/screens/interestScreen.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;

import 'bottomNavigationBarWidgetDark.dart';

class DrawerMenuWidget extends BaseRoute {
  final String? currentUserId;
  final User2? matchedUserData;
  DrawerMenuWidget({a, o,this.currentUserId,this.matchedUserData}) : super(a: a, o: o, r: 'DrawerMenuWidget');
  @override
  _DrawerMenuWidgetState createState() => new _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends BaseRouteState {
  TextEditingController report = TextEditingController();
  String? _report ;
  _DrawerMenuWidgetState() : super();

  @override
  void dispose() {
    super.dispose();
  }
  Future<void> _reportingUser() async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
          TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width / 2,
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
                              controller: report,
                              style: TextStyle(fontSize: 18.0,color: Theme.of(context).primaryColorLight),
                              decoration: InputDecoration(
                                labelText: 'report',
                                labelStyle:
                                Theme.of(context).primaryTextTheme.subtitle2,
                                contentPadding: g.isRTL
                                    ? EdgeInsets.only(right: 20)
                                    : EdgeInsets.only(left: 20),
                                focusedBorder: UnderlineInputBorder(

                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                border: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              onChanged: (input) => _report = input,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColorLight),
                                  onPressed: () async {
                                  FirebaseFirestore.instance.collection("reports").doc(widget.matchedUserData!.id).collection("issues").add({
                                    'issue': report.text.toString(),
                                  });

                                    Navigator.pop(context);


                                  },
                                  child: Text(
                                    "Send",
                                    textScaleFactor: 0.7,
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
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
  _deleteChat() {
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
                        "Sure you want to delete this chat",
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
                          usersRef.doc(widget.currentUserId).collection("Matched").doc(widget.matchedUserData!.id).delete();
                          g.isDarkModeEnable
                              ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetDark(
                                currentUserId: widget.currentUserId,
                                currentIndex: 2,
                                a: widget.analytics,
                                o: widget.observer,
                              )))
                              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetLight(
                                currentUserId: widget.currentUserId,
                                currentIndex: 2,
                                a: widget.analytics,
                                o: widget.observer,
                              )
                          ));


                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                            Theme.of(context).primaryColorLight,

                            content: Text("Chat deleted"),
                            //  backgroundColor: Colors.black,
                          ));
                        },
                        child: Text(
                          "yes",
                          style: Theme.of(context).accentTextTheme.headline6,
                        )),
                    TextButton(
                        onPressed: () async {

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                            Theme.of(context).primaryColorLight,
                            content: Text("Request dismissed"),
                            //  backgroundColor: Colors.black,
                          ));
                        },
                        child: Text("no",
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
  _clearHistory() {
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
                          usersRef.doc(widget.currentUserId).collection("Matched").doc(widget.matchedUserData!.id).collection("Messages").get().then((value) {
                            value.docs.forEach((element) {
                              element.reference.delete();
                            });

                          });


                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                            Theme.of(context).primaryColorLight,

                            content: Text("Chat History Cleared"),
                            //  backgroundColor: Colors.black,
                          ));
                        },
                        child: Text(
                          "yes",
                          style: Theme.of(context).accentTextTheme.headline6,
                        )),
                    TextButton(
                        onPressed: () async {

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                            Theme.of(context).primaryColorLight,
                            content: Text("Request dismissed"),
                            //  backgroundColor: Colors.black,
                          ));
                        },
                        child: Text("no",
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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
            ),
            child: Drawer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xffD6376E), Color(0xFFAD45B3)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'View Profile',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {

                        print(widget.matchedUserData!.name);
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    IntrestScreen(
                                      datingUser:
                                      widget.matchedUserData,
                                      currentUserId: widget
                                          .currentUserId,
                                      a: widget
                                          .analytics,
                                      o: widget
                                          .observer,
                                    )));
                      },
                    ),

                    // ListTile(
                    //   leading: Icon(
                    //     MdiIcons.archiveOutline,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Archive Conversation',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Delete Chat',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {
                     _deleteChat();

                      },
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Clear History',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {
                       _clearHistory();
                      },
                    ),

                    // Divider(
                    //   color: Colors.white54,
                    // ),
                    // ListTile(
                    //   leading: Icon(
                    //     MdiIcons.viewArray,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'View Media',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    Divider(
                      color: Colors.white54,
                    ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.block,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Block User',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // Divider(
                    //   color: Colors.white54,
                    // ),
                    ListTile(
                      leading: Icon(
                        Icons.report,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Report User',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: _reportingUser,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
