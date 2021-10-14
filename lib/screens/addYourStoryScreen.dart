import 'package:uni_dating/models/addYourStoryModel.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/createStoryScreen.dart';
import 'package:uni_dating/screens/filterOptionsScreen.dart';
import 'package:uni_dating/screens/interestScreen.dart';

import 'package:uni_dating/screens/notificationListScreen.dart';
import 'package:uni_dating/screens/viewStoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddYourStoryScreen extends BaseRoute {
  AddYourStoryScreen({a, o}) : super(a: a, o: o, r: 'AddYourStoryScreen');
  @override
  _AddYourStoryScreenState createState() => _AddYourStoryScreenState();
}

class _AddYourStoryScreenState extends BaseRouteState {
  int _currentIndex = 0;
 late TabController _tabController;

  final List<String> circleImageList = [
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
  ];

  List<AddYourStory> _storyList = [
    new AddYourStory(name: 'Belle Benson', age: 28, km: 1.5, imgPath: 'assets/images/card_img_0.png', count: 35),
    new AddYourStory(name: 'Ruby Diaz', age: 33, km: 1.2, imgPath: 'assets/images/card_img_1.png', count: 81),
    new AddYourStory(name: 'Myley Corbyon', age: 23, km: 1.5, imgPath: 'assets/images/card_img_2.png', count: 49),
    new AddYourStory(name: 'Tony Z', age: 25, km: 2, imgPath: 'assets/images/card_img_1.png', count: 29),
    new AddYourStory(name: 'Ruby Raman', age: 30, km: 1.6, imgPath: 'assets/images/card_img_4.png', count: 50),
  ];

  _AddYourStoryScreenState() : super();

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
            body: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: g.isRTL ? const EdgeInsets.only(right: 15) : EdgeInsets.only(left: 10),
                    child: Image.asset(
                      g.isDarkModeEnable ? 'assets/images/swirl arrow.png' : 'assets/images/swirl arrow_light.png',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: circleImageList.length,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () {
                              index == 0
                                  ? Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CreateStoryScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )))
                                  : Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewStoryScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                            },
                            child: Padding(
                              padding: g.isRTL ? const EdgeInsets.only(left: 10) : const EdgeInsets.only(right: 10),
                              child: index == 0
                                  ? CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xFFF1405B),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 26,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xFFF1405B),
                                        backgroundImage: AssetImage(
                                          circleImageList[index],
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                        Tab(text: AppLocalizations.of(context)!.lbl_Tab_All),
                        Tab(text: AppLocalizations.of(context)!.lbl_Tab_Online),
                        Tab(text: AppLocalizations.of(context)!.lbl_Tab_new_daters),
                        Tab(text: AppLocalizations.of(context)!.lbl_Tab_liked_you),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          itemCount: _storyList.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => IntrestScreen(
                                          a: widget.analytics,
                                          o: widget.observer,
                                        )));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white),
                                  color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                ),
                                child: GridTile(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      '${_storyList[index].imgPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  header: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.lightGreenAccent[400],
                                      ),
                                    ),
                                  ),
                                  footer: ListTile(
                                    contentPadding: EdgeInsets.only(left: 12, bottom: 4),
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${_storyList[index].name},${_storyList[index].age}',
                                            style: Theme.of(context).accentTextTheme.headline4,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.all(0),
                                              child: Text(
                                                '${_storyList[index].km} km away',
                                                style: Theme.of(context).primaryTextTheme.headline6,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 4, right: 8),
                                                  child: Text(
                                                    '${_storyList[index].count}',
                                                    style: Theme.of(context).primaryTextTheme.headline6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          itemCount: _storyList.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => IntrestScreen(
                                          a: widget.analytics,
                                          o: widget.observer,
                                        )));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white),
                                  color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                ),
                                child: GridTile(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      '${_storyList[index].imgPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  header: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.lightGreenAccent[400],
                                      ),
                                    ),
                                  ),
                                  footer: ListTile(
                                    contentPadding: EdgeInsets.only(left: 12, bottom: 4),
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${_storyList[index].name},${_storyList[index].age}',
                                            style: Theme.of(context).accentTextTheme.headline4,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.all(0),
                                              child: Text(
                                                '${_storyList[index].km} km away',
                                                style: Theme.of(context).primaryTextTheme.headline6,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 4, right: 8),
                                                  child: Text(
                                                    '${_storyList[index].count}',
                                                    style: Theme.of(context).primaryTextTheme.headline6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          itemCount: _storyList.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => IntrestScreen(
                                          a: widget.analytics,
                                          o: widget.observer,
                                        )));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white),
                                  color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                ),
                                child: GridTile(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      '${_storyList[index].imgPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  header: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.lightGreenAccent[400],
                                      ),
                                    ),
                                  ),
                                  footer: ListTile(
                                    contentPadding: EdgeInsets.only(left: 12, bottom: 4),
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${_storyList[index].name},${_storyList[index].age}',
                                            style: Theme.of(context).accentTextTheme.headline4,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.all(0),
                                              child: Text(
                                                '${_storyList[index].km} km away',
                                                style: Theme.of(context).primaryTextTheme.headline6,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 4, right: 8),
                                                  child: Text(
                                                    '${_storyList[index].count}',
                                                    style: Theme.of(context).primaryTextTheme.headline6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          itemCount: _storyList.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => IntrestScreen(
                                          a: widget.analytics,
                                          o: widget.observer,
                                        )));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white),
                                  color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                                ),
                                child: GridTile(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      '${_storyList[index].imgPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  header: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.lightGreenAccent[400],
                                      ),
                                    ),
                                  ),
                                  footer: ListTile(
                                    contentPadding: EdgeInsets.only(left: 12, bottom: 4),
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${_storyList[index].name},${_storyList[index].age}',
                                            style: Theme.of(context).accentTextTheme.headline4,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: g.isRTL ? EdgeInsets.only(right: 6) : EdgeInsets.all(0),
                                              child: Text(
                                                '${_storyList[index].km} km away',
                                                style: Theme.of(context).primaryTextTheme.headline6,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 4, right: 8),
                                                  child: Text(
                                                    '${_storyList[index].count}',
                                                    style: Theme.of(context).primaryTextTheme.headline6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
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

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        AppLocalizations.of(context)!.lbl_Add_your_Story,
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.notifications_rounded,
                          ),
                        ),
                        color: Theme.of(context).iconTheme.color,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NotificationListScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Align(alignment: Alignment.bottomRight, child: (Icon(MdiIcons.tuneVerticalVariant))),
                      color: Theme.of(context).iconTheme.color,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilterOptionsScreen(
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
