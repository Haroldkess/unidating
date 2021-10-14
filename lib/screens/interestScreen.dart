import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/startConversionScreen.dart';
import 'package:uni_dating/screens/startSwippingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntrestScreen extends BaseRoute {
  IntrestScreen({a, o}) : super(a: a, o: o, r: 'IntrestScreen');
  @override
  _IntrestScreenState createState() => _IntrestScreenState();
}

class _IntrestScreenState extends BaseRouteState {
  int _currentIndex = 0;
  late TabController _tabController;
  final List<String> imgList = [
    'assets/images/profile_img_0.png',
    'assets/images/profile_img_1.png',
    'assets/images/profile_img_2.png',
    'assets/images/profile_img_3.png',
    'assets/images/profile_img_0.png',
  ];
  _IntrestScreenState() : super();

  @override
  Widget build(BuildContext context) {
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
          appBar: _appBarWidget(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Image.asset(
                        'assets/images/prof_img.png',
                        fit: BoxFit.fitWidth,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(19, 1, 51, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFF130032),
                        child: IconButton(
                          icon: Icon(MdiIcons.messageReplyTextOutline),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StartConversionScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          },
                        )),
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
                    width: MediaQuery.of(context).size.width / 1.9,
                    height: 15,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF984cd9),
                          Color(0xFFb245af),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Text(
                                  'Belle Benson',
                                  style: Theme.of(context).primaryTextTheme.headline1,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 30,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.place,
                                          color: Theme.of(context).iconTheme.color,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            '1.5 km away',
                                            style: Theme.of(context).primaryTextTheme.bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.only(left: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          color: Theme.of(context).iconTheme.color,
                                          size: 20,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => StartConversionScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      gradient: LinearGradient(
                                        colors: [Colors.green[200]!, Colors.green[900]!],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 22,
                                      child: Icon(
                                        Icons.thumb_up,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => StartSwippingScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      gradient: LinearGradient(
                                        colors: [Colors.red[200]!, Colors.pink[700]!],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 22,
                                      child: Icon(
                                        Icons.thumb_down,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          AppLocalizations.of(context)!.lbl_hello_friends,
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
                                        'Belle ${AppLocalizations.of(context)!.lbl_tab_Bio}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Belle ${AppLocalizations.of(context)!.lbl_tab_Bio}',
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
                                  margin: g.isRTL ? EdgeInsets.only(top: 20, right: 20) : EdgeInsets.only(top: 20, left: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white),
                                    color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                  ),
                                  height: (MediaQuery.of(context).size.height * 0.12),
                                  width: MediaQuery.of(context).size.width,
                                  child: GridTile(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        imgList[index],
                                        height: (MediaQuery.of(context).size.height * 0.12),
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.fitWidth,
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
                                  padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 20) : const EdgeInsets.only(left: 20, top: 20),
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
                                       // Icons.travel_explore,
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
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFCC3263),
            width: MediaQuery.of(context).size.width / 1.9,
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
