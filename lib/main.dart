import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_dating/Theme/nativeTheme.dart';
import 'package:uni_dating/google_sign_in.dart';
import 'package:uni_dating/l10n/l10n.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/provider/local_provider.dart';
import 'package:uni_dating/screens/loginScreen.dart';
import 'package:uni_dating/screens/profileDetailScreen.dart';
import 'package:uni_dating/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

var routes = <String, WidgetBuilder>{



  "/SplashScreen": (BuildContext context) => SplashScreen(),
  "/ProfileDetailScreen": (BuildContext context) => ProfileDetailScreen(

),




};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  dynamic analytics;
  dynamic observer;

  @override
  void initState() {
    super.initState();
    //_init();
  }

  // Future () async {
  //   try {
  //     var brightness = SchedulerBinding.instance.window.platformBrightness;
  //     print("HEllo main");
  //     bool isDarkMode = brightness == Brightness.dark;
  //     g.isDarkModeEnable = isDarkMode;
  //   } catch (e) {
  //     print('Exception - base.dart - (): ' + e.toString());
  //   }
  // }

  // _init() async {
  //   try {
  //     SharedPreferences sp = await SharedPreferences.getInstance();
  //     if (sp.containsKey('isDarkMode') && sp.getBool('isDarkMode') != null) {
  //       g.isDarkModeEnable = sp.getBool('isDarkMode');
  //     } else {
  //       g.isDarkModeEnable = false;
  //     }
  //   } catch (e) {
  //     print('Exception - main.dart - _init(): ' + e.toString());
  //   }
  // }
  Widget _getScreenId() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        else if (snapshot.hasError)
        {
          return Center(
            child: Text("Something went wrong!!!"),
          );
        }
         if (snapshot.hasData)
        {
          Provider.of<GoogleSignInProvider>(context, listen:  false);
          final user = FirebaseAuth.instance.currentUser!;
         // print(user.uid);

          return SplashScreen(
            currentUserId: user.uid,
            a: analytics,
            o: observer,
          );
        }

        else {
         // Provider.of<GoogleSignInProvider>(context, listen: false);
          return LoginScreen(a: analytics, o: observer);
        }

      },
    );

  }
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<LocaleProvider>(context,listen:  false);
    return  ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      builder: (context, child){
        return MaterialApp(
          title: "UniDating",
          debugShowCheckedModeBanner: false,
          theme: nativeTheme(g.isDarkModeEnable),
          home: _getScreenId(),
          routes: routes,

        );
      },

    );
  }
}

