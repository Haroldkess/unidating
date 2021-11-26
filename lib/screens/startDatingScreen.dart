import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/likes&IntrestScreen.dart';
import 'package:uni_dating/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uni_dating/screens/startupprofileEdit.dart';

class StartDatingScreen extends BaseRoute {
  final String? currentUserId;
  StartDatingScreen({a, o,this.currentUserId}) : super(a: a, o: o, r: 'StartDatingScreen');
  @override
  _StartDatingScreenState createState() => _StartDatingScreenState();
}

class _StartDatingScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _StartDatingScreenState() : super();

  Widget ui (BuildContext context, AsyncSnapshot snapshot , User user)
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
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Online Dating App",
                        style: Theme.of(context).primaryTextTheme.headline4,
                      ),
                    ),
                    Text(
                      "Find Your",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                    Text(
                      "Best Match",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Wanna know how the app works?",
                        style: TextStyle(
                          color: g.isDarkModeEnable ? Colors.white70 : Color(0xFF5E50E5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Play the Video",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Image.asset(
                      g.isDarkModeEnable ? 'assets/images/start_dating_new.png' : 'assets/images/start_dating_new.png',
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
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
                            print(widget.currentUserId);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => StartUpEditProfilePage(
                                  thisProfileUser: user,
                                  currentUserId: widget.currentUserId,
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                          },
                          child: Text(
                            "Start Dating",
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
        ));
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
  }
}
