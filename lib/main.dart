import 'package:uni_dating/Theme/nativeTheme.dart';
import 'package:uni_dating/l10n/l10n.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/provider/local_provider.dart';
import 'package:uni_dating/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: nativeTheme(g.isDarkModeEnable),
          home: SplashScreen(a: analytics, o: observer),
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      });
}
