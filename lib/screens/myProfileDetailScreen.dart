import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProfileSceen extends BaseRoute {
  MyProfileSceen({a, o}) : super(a: a, o: o, r: 'MyProfileSceen');
  @override
  _MyProfileSceenState createState() => _MyProfileSceenState();
}

class _MyProfileSceenState extends BaseRouteState {
  int _currentIndex = 0;
 late TabController _tabController;
  _MyProfileSceenState() : super();

  @override
  Widget build(BuildContext context) {
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
            appBar: _appBarWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Container(
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(19, 1, 51, 1),
                        ),
                      ),
                    ),
                    Container(
                      color: g.isDarkModeEnable ? Color(0xFF130032) : Colors.white,
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColorLight,
                                  size: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    '2.7k',
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColorLight,
                                  size: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    '3.5k',
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColorLight,
                                  size: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    '2.3k',
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: LinearGradient(
                                colors: [Colors.blue[900]!, Colors.blueAccent[700]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Icon(
                                Icons.border_color,
                             //   Icons.border_color_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width,
                      color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      color: Color(0xFFAD45B3),
                      width: MediaQuery.of(context).size.width / 2 - 35,
                      height: 15,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              'Mathew Ben',
                              style: Theme.of(context).primaryTextTheme.headline1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20) : const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        '+01 331 623 8413',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 30,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.mail,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'mathew@gmail.com',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 30),
                          child: Text(
                            AppLocalizations.of(context)!.lbl_short_bio,
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 10) : const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Love music, cooking, swimming, going out,\ntravelling etc. Wanna be friends??',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Theme.of(context).iconTheme.color,
                            onTap: (int index) async {
                              _currentIndex = index;
                              setState(() {});
                            },
                            tabs: [
                              _tabController.index == 0
                                  ? Tab(
                                      child: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            colors: g.gradientColors,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ).createShader(bounds);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_tab_pictures,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.lbl_tab_pictures,
                                      style: TextStyle(fontSize: 16),
                                    ),
                              _tabController.index == 1
                                  ? Tab(
                                      child: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            colors: g.gradientColors,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ).createShader(bounds);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_tab_videos,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.lbl_tab_videos,
                                      style: TextStyle(fontSize: 16),
                                    ),
                              _tabController.index == 2
                                  ? Tab(
                                      child: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            colors: g.gradientColors,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ).createShader(bounds);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_tab_mybio,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.lbl_tab_mybio,
                                      style: TextStyle(fontSize: 16),
                                    ),
                              _tabController.index == 3
                                  ? Tab(
                                      child: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            colors: g.gradientColors,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ).createShader(bounds);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_tab_more,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.lbl_tab_more,
                                      style: TextStyle(fontSize: 16),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height * 0.12),
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: MediaQuery.of(context).size.width,
                                  mainAxisSpacing: 2.0,
                                  crossAxisSpacing: 2.0,
                                ),
                                itemCount: 5,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20, left: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white),
                                      color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                    ),
                                    height: (MediaQuery.of(context).size.height * 0.12),
                                    width: MediaQuery.of(context).size.width,
                                    child: GridTile(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(19),
                                        child: Image.asset(
                                          'assets/images/sample1.jpg',
                                          height: (MediaQuery.of(context).size.height * 0.12),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Container(),
                              Container(),
                              Container()
                            ],
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 30),
                          child: Text(
                            AppLocalizations.of(context)!.lbl_intrests,
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: g.isRTL ? EdgeInsets.only(right: 20, top: 20) : EdgeInsets.only(left: 20, top: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          MdiIcons.music,
                                          color: Color(0xFFB783EB),
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            'Music',
                                            style: Theme.of(context).accentTextTheme.subtitle2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          MdiIcons.cookie,
                                          color: Color(0xFFB783EB),
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            'Cooking',
                                            style: Theme.of(context).accentTextTheme.subtitle2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          MdiIcons.swim,
                                          color: Color(0xFFB783EB),
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            'Swimming',
                                            style: Theme.of(context).accentTextTheme.subtitle2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.explore,
                                        //  Icons.travel_explore,
                                          color: Color(0xFFB783EB),
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            'Travelling',
                                            style: Theme.of(context).accentTextTheme.subtitle2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: g.isRTL ? Alignment.centerLeft : Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingScreen(
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
            ),
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
}
