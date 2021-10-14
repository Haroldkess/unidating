import 'package:flutter/material.dart';

ThemeData nativeTheme(bool isDarkModeEnable) {
  if (isDarkModeEnable) {
    return ThemeData(
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white, selectionHandleColor: Colors.white),
        primaryColor: Color(0xFF14012E),
        primaryColorDark: Color(0xFF14012E),
        primaryColorLight: Color(0xFFDD3663),
        appBarTheme: AppBarTheme(color: Colors.transparent),
        primaryTextTheme: TextTheme(
          headline1: TextStyle(fontSize: 29, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 0.3),
          headline2: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
          headline3: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.w400),
          headline4: TextStyle(color: Color(0xFFEF3A6A), fontSize: 12, fontWeight: FontWeight.w600),
          headline5: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 10, color: Colors.white),
          subtitle1: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          subtitle2: TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.normal),
          bodyText1: TextStyle(fontSize: 13, color: Colors.white70),
          bodyText2: TextStyle(fontSize: 10, color: Colors.white60, fontWeight: FontWeight.w400),
          caption: TextStyle(color: Colors.grey[800], fontSize: 10), // for display time
          overline: TextStyle(color: Colors.grey[800], fontSize: 10, fontWeight: FontWeight.normal, letterSpacing: 0),
        ),
        accentTextTheme: TextTheme(
          headline1: TextStyle(fontSize: 22, color: Color(0xFF33196B), fontWeight: FontWeight.w500),
          headline2: TextStyle(color: Colors.white, fontSize: 20),
          headline3: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.w400),
          headline4: TextStyle(fontSize: 14, color: Colors.white),
          headline5: TextStyle(color: Color(0xFFEF3A6A), fontSize: 14, fontWeight: FontWeight.w600), // filter options title
          headline6: TextStyle(fontSize: 14, color: Color(0xFFDD3663)), // likes and intrests skip
          subtitle1: TextStyle(color: Colors.white70, fontSize: 12),
          subtitle2: TextStyle(color: Color(0xFFB783EB), fontSize: 12), // tabbar Tabs text style
          overline: TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.normal, letterSpacing: 0),
          caption: TextStyle(fontSize: 13, color: Color(0xFF33196B), fontWeight: FontWeight.w400), // payment card detils text
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(fontSize: 22, color: Color(0xFFDD3663), fontWeight: FontWeight.bold), // reward selected text
          headline3: TextStyle(fontSize: 22, color: Color(0xFF33196B), fontWeight: FontWeight.bold), // reward dialog text
          headline4: TextStyle(color: Colors.white, fontSize: 18),
          headline5: TextStyle(fontSize: 14, color: Color(0xFF33196B), fontWeight: FontWeight.w700), // rewars dialog
          headline6: TextStyle(color: Color(0xFF8169DE), fontSize: 14), // payment Liked Text
          subtitle1: TextStyle(fontSize: 13, color: Colors.white), // plan dating subtitle
          subtitle2: TextStyle(fontSize: 13, color: Colors.white60), // rewars subtitle
          bodyText1: TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.w600),
          bodyText2: TextStyle(fontSize: 14, color: Color(0xFFDD3663), fontWeight: FontWeight.w700),
          caption: TextStyle(fontSize: 13, color: Color(0xFFDD3663), fontWeight: FontWeight.w400),
          overline: TextStyle(color: Color(0xFFDD3663), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Lexend',
        dividerColor: Colors.transparent,
        disabledColor: Color(0xFF33196B),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Color(0xFF862254),
          unselectedLabelColor: Color(0xFF483585),
          labelStyle: TextStyle(fontSize: 14, color: Color(0xFF862254), fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontSize: 14, color: Color(0xFF483585), fontWeight: FontWeight.w500),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(color: Colors.transparent, size: 26),
          unselectedIconTheme: IconThemeData(color: Colors.transparent, size: 26),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ));
  } else {
    return ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFF33196B),
          selectionHandleColor: Color(0xFF33196B),
        ),
        primaryColor: Color(0xFF14012E),
        primaryColorLight: Color(0xFFDD3663),
        primaryColorDark: Color(0xFF14012E),
        disabledColor: Color(0xFF33196B),
        appBarTheme: AppBarTheme(color: Colors.transparent),
        primaryTextTheme: TextTheme(
          headline1: TextStyle(fontSize: 29, color: Color(0xFF33196B), fontWeight: FontWeight.w700, letterSpacing: 0.3),
          headline2: TextStyle(fontSize: 22, color: Color(0xFF33196B), fontWeight: FontWeight.w500),
          headline3: TextStyle(fontSize: 19, color: Color(0xFF33196B), fontWeight: FontWeight.w400),
          headline4: TextStyle(color: Color(0xFF33196B), fontSize: 12, fontWeight: FontWeight.w600),
          headline5: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF33196B)),
          headline6: TextStyle(fontSize: 10, color: Colors.white),
          subtitle1: TextStyle(fontSize: 14, color: Color(0xFF33196B), fontWeight: FontWeight.w700),
          subtitle2: TextStyle(fontSize: 13, color: Color(0xFF33196B), fontWeight: FontWeight.w400),
          bodyText1: TextStyle(fontSize: 13, color: Color(0xFF33196B), fontWeight: FontWeight.w500),
          bodyText2: TextStyle(fontSize: 10, color: Color(0xFF33196B), fontWeight: FontWeight.w400),
          caption: TextStyle(color: Colors.grey[800], fontSize: 10), // for display time
          overline: TextStyle(color: Colors.purple[100], fontSize: 10, fontWeight: FontWeight.normal, letterSpacing: 0),
        ),
        accentTextTheme: TextTheme(
          headline1: TextStyle(fontSize: 22, color: Color(0xFF33196B), fontWeight: FontWeight.w500),
          headline2: TextStyle(color: Colors.white, fontSize: 20),
          headline3: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.w400),
          headline4: TextStyle(fontSize: 14, color: Colors.white),
          headline5: TextStyle(color: Color(0xFF33196B), fontSize: 14), // filter options title
          headline6: TextStyle(fontSize: 14, color: Color(0xFFDD3663)), // filter oprions distance show
          subtitle1: TextStyle(color: Colors.white70, fontSize: 12),
          subtitle2: TextStyle(color: Color(0xFFB783EB), fontSize: 12), // tabbar Tabs text style
          bodyText1: TextStyle(color: Color(0xFFC43F8E), fontSize: 13), // chat title
          bodyText2: TextStyle(color: Color(0xFF4635E2), fontSize: 13, fontWeight: FontWeight.bold), // chat title
          overline: TextStyle(color: Color(0xFF845EB5), fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0), // likes and intrest text
          caption: TextStyle(fontSize: 13, color: Color(0xFF33196B), fontWeight: FontWeight.w400), // payment card detils text
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF33196B)),
          headline2: TextStyle(fontSize: 22, color: Color(0xFFDD3663), fontWeight: FontWeight.bold), // reward selected text
          headline3: TextStyle(fontSize: 22, color: Color(0xFF33196B), fontWeight: FontWeight.bold), // reward dialog text
          headline4: TextStyle(color: Colors.white, fontSize: 18),
          headline5: TextStyle(fontSize: 14, color: Color(0xFF33196B), fontWeight: FontWeight.w700), // rewars dialog
          headline6: TextStyle(color: Color(0xFF8169DE), fontSize: 14), // payment Liked Text
          subtitle1: TextStyle(fontSize: 13, color: Colors.white),
          subtitle2: TextStyle(fontSize: 13, color: Colors.white60), // rewars subtitle
          bodyText1: TextStyle(color: Color(0xFFDD3663), fontWeight: FontWeight.w600),
          bodyText2: TextStyle(fontSize: 14, color: Color(0xFFDD3663), fontWeight: FontWeight.w700),
          caption: TextStyle(fontSize: 13, color: Color(0xFFDD3663), fontWeight: FontWeight.w400),
          overline: TextStyle(color: Color(0xFFDD3663), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        scaffoldBackgroundColor: Color(0xFFEEFCFF),
        fontFamily: 'Lexend',
        dividerColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(fontSize: 15, color: Color(0xFF33196B), fontWeight: FontWeight.w400),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(color: Colors.transparent, size: 26),
          unselectedIconTheme: IconThemeData(color: Colors.transparent, size: 26),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF3929C7)),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Color(0xFF483585),
          labelPadding: EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Color(0xFF33196B),
          labelStyle: TextStyle(fontSize: 14, color: Color(0xFF862254), fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontSize: 14, color: Color(0xFF483585), fontWeight: FontWeight.w500),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ));
  }
}
