import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/models/datingMatchedModel.dart';
import 'package:uni_dating/screens/settingScreen.dart';
import 'package:uni_dating/screens/viewPlanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatingMatchesScreen extends BaseRoute {
  final String? currentUserId;
  DatingMatchesScreen({a, o,this.currentUserId}) : super(a: a, o: o, r: 'DatingMatchesScreen');
  @override
  _DatingMatchesScreenState createState() => _DatingMatchesScreenState();
}

class _DatingMatchesScreenState extends BaseRouteState {
  int _currentIndex = 0;
 late TabController _tabController;

  List<DatingMachedModel> _datingMatchesList = [
    new DatingMachedModel(name: 'Ruby Raman', time: '12:20 AM', description: 'Found from matches proposal', imgPath: 'assets/images/img_circle_0.png'),
    new DatingMachedModel(name: 'Sara Chistin', time: '12:20 AM', description: 'Found from matches proposal', imgPath: 'assets/images/sample3.png'),
    new DatingMachedModel(name: 'Myley Corbyn', time: '12:20 AM', description: 'Found from matches proposal', imgPath: 'assets/images/sample3.png'),
    new DatingMachedModel(name: 'Sansa Ban', time: '12:20 AM', description: 'Found from matches proposal', imgPath: 'assets/images/img_circle_0.png'),
    new DatingMachedModel(name: 'Belle Benson', time: '12:20 AM', description: 'Found from matches proposal', imgPath: 'assets/images/msg_img.png'),
  ];
  _DatingMatchesScreenState() : super();

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
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingScreen(
                      currentUserId: widget.currentUserId ,
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Dating Matches",
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Check out lists of matches & keep enjoying",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: TabBar(
                      labelPadding: EdgeInsets.only(right: 30),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.only(right: 30),
                      isScrollable: true,
                      controller: _tabController,
                      indicatorColor: Theme.of(context).iconTheme.color,
                      onTap: (int index) async {
                        _currentIndex = index;
                        setState(() {});
                      },
                      tabs: [
                        Tab(text: "All"),
                        Tab(text: "You Liked"),
                        Tab(text: "Liked You"),
                        Tab(text: "Views"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          itemCount: _datingMatchesList.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 31,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                              _datingMatchesList[index].imgPath,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: g.isRTL ? const EdgeInsets.only(right: 12) : const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${_datingMatchesList[index].name}',
                                                style: Theme.of(context).primaryTextTheme.subtitle1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4, bottom: 4),
                                                child: Text(
                                                  '${_datingMatchesList[index].description}',
                                                  style: Theme.of(context).primaryTextTheme.bodyText2,
                                                ),
                                              ),
                                              Text(
                                                '${_datingMatchesList[index].time} | 29.04.2022',
                                                style: Theme.of(context).primaryTextTheme.caption,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.more_vert,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 32,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => ViewPlanScreen(
                                                a: widget.analytics,
                                                o: widget.observer,
                                              )));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 12, bottom: 12),
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: g.gradientColors,
                                    ),
                                  ),
                                  child: Divider(),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 6,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 31,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                              'assets/images/msg_img.png',
                                            ),
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: g.isRTL ? const EdgeInsets.only(right: 12) : const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ruby Raman',
                                                style: Theme.of(context).primaryTextTheme.subtitle1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4, bottom: 4),
                                                child: Text(
                                                  'Found from matches proposal',
                                                  style: Theme.of(context).primaryTextTheme.bodyText2,
                                                ),
                                              ),
                                              Text(
                                                '12:20 AM | 29.04.2022',
                                                style: Theme.of(context).primaryTextTheme.caption,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.more_vert,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 32,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => ViewPlanScreen(
                                            currentUserId: widget.currentUserId,
                                                a: widget.analytics,
                                                o: widget.observer,
                                              )));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 12, bottom: 12),
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: g.gradientColors,
                                    ),
                                  ),
                                  child: Divider(),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 6,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 31,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                              'assets/images/msg_img.png',
                                            ),
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: g.isRTL ? const EdgeInsets.only(right: 12) : const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ruby Raman',
                                                style: Theme.of(context).primaryTextTheme.subtitle1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4, bottom: 4),
                                                child: Text(
                                                  'Found from matches proposal',
                                                  style: Theme.of(context).primaryTextTheme.bodyText2,
                                                ),
                                              ),
                                              Text(
                                                '12:20 AM | 29.04.2022',
                                                style: Theme.of(context).primaryTextTheme.caption,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.more_vert,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 32,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => ViewPlanScreen(
                                                a: widget.analytics,
                                                o: widget.observer,
                                              )));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 12, bottom: 12),
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: g.gradientColors,
                                    ),
                                  ),
                                  child: Divider(),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 6,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 31,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                              'assets/images/msg_img.png',
                                            ),
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: g.isRTL ? const EdgeInsets.only(right: 12) : const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ruby Raman',
                                                style: Theme.of(context).primaryTextTheme.subtitle1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4, bottom: 4),
                                                child: Text(
                                                  'Found from matches proposal',
                                                  style: Theme.of(context).primaryTextTheme.bodyText2,
                                                ),
                                              ),
                                              Text(
                                                '12:20 AM | 29.04.2022',
                                                style: Theme.of(context).primaryTextTheme.caption,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.more_vert,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 32,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => ViewPlanScreen(
                                                a: widget.analytics,
                                                o: widget.observer,
                                              )));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 12, bottom: 12),
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: g.gradientColors,
                                    ),
                                  ),
                                  child: Divider(),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
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
    _tabController = new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }
}
