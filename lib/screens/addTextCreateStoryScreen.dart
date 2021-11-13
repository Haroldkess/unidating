import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddTextCreateStory extends BaseRoute {
  final String? currentUserId;
  final User2? matchedUserData;

  AddTextCreateStory({a, o, this.currentUserId, this.matchedUserData})
      : super(a: a, o: o, r: 'AddTextCreateStory');

  @override
  _AddTextCreateStoryState createState() => new _AddTextCreateStoryState();
}

class _AddTextCreateStoryState extends BaseRouteState {
  TextEditingController _cText = new TextEditingController();
List <String> _user = [];
  _AddTextCreateStoryState() : super();

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
        return statusPostUi(context, snapshot, thisUser);
      },
    );
  }

  Widget statusPostUi(BuildContext context, AsyncSnapshot snapshot, User thisUser){
    return  SafeArea(
      child: WillPopScope(
          onWillPop: () {
            Navigator.of(context).pop();
            return null!;
          },
          child:  Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: g.gradientColors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Scaffold(
              appBar: _appBarWidget(thisUser),
              backgroundColor: Colors.transparent,
              body: Center(
                child: TextFormField(
                  maxLines: 10,
                  style: Theme.of(context).accentTextTheme.headline2,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.center,
                  controller: _cText,
                  decoration: InputDecoration(
                      hintText: "Start Typing",
                      hintStyle: TextStyle(
                        fontSize: 26,
                      )),
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
  bool? isLoading;

  PreferredSizeWidget _appBarWidget(User thisUser) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(FontAwesomeIcons.longArrowAltLeft),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            highlightColor: Colors.transparent,
            onTap: () async {
              setState(() {
                isLoading = true;
              });

            await  usersRef
                  .doc(widget.currentUserId)
                  .collection("Matched")
                  .get()
                  .then((value) {

                value.docs.forEach((element) async {

              _user.add(element.reference.id);
              print(element.id.toString());
              print(element.reference.id.toString());
              print(value.docs.toString());

              usersRef
                      .doc(element.reference.id.toString())
                      .collection("StatusPost").doc(widget.currentUserId).collection("status")
                      .add({
                'text': _cText.text.toString(),
                'id': widget.currentUserId ,
                'profileImage': thisUser.profileImageUrl,
                'name' : thisUser.name,
                'type': 'text',
                'timestamp': Timestamp.now().toDate().toLocal(),

                      });
              print("done");
              print(element.id.toString());
              print(element.reference.id.toString());
              print(value.docs.toString());
                });
              });
              setState(() {
                isLoading = false;
              });


            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text("Status updated"),
              backgroundColor: Theme.of(context).primaryColorLight,
              //  backgroundColor: Colors.black,
            ));


            Navigator.of(context).pop();

            },
            child: Padding(
              padding: g.isRTL
                  ? const EdgeInsets.only(left: 6)
                  : const EdgeInsets.only(right: 10.0),
              child: isLoading == false ? Text(
                "Post",
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ):
              Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
