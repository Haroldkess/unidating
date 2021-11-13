import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/buyTicketsScreen.dart';
import 'package:uni_dating/screens/datingMatchingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlanDatingScreen extends BaseRoute {
  final String? currentUserId;
  PlanDatingScreen({a, o,this.currentUserId}) : super(a: a, o: o, r: 'PlanDatingScreen');

  @override
  _PlanDatingScreenState createState() => _PlanDatingScreenState();
}

class _PlanDatingScreenState extends BaseRouteState {
  int _currentIndex = 0;
  late TabController _tabController;
  TextEditingController _cSearch = new TextEditingController();
  _PlanDatingScreenState()   : super();

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
                    builder: (context) => DatingMatchesScreen(
                      currentUserId: widget.currentUserId,
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
                        "Plan Dating",
                        style: Theme.of(context).primaryTextTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Reserve seat, place, book tickets etc to make your dating even more exciting..",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(2),
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: g.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                          controller: _cSearch,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: g.isRTL ? EdgeInsets.only(right: 22, top: 15) : EdgeInsets.only(left: 22, top: 15),
                            hintText: "Search Message,Match",
                            hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                FontAwesomeIcons.search,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: TabBar(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        labelPadding: g.isRTL ? EdgeInsets.only(left: 50) : EdgeInsets.only(right: 50),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: g.isRTL ? EdgeInsets.only(left: 50) : EdgeInsets.only(right: 50),
                        isScrollable: true,
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
                                      "Popular",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              : Text(
                                  "Popular",
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
                                      "Events",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              : Text(
                                  "Events",
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
                                      "Parties",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              : Text(
                                  "Parties",
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
                                      "Parties",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              : Text(
                                  "Parties",
                                  style: TextStyle(fontSize: 16),
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: 6,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => BuyTicketsScreen(
                                        currentUserId: widget.currentUserId,
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18.5),
                                          child: Image.asset(
                                            'assets/images/plan_dating.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.5),
                                          color: Color.fromRGBO(19, 1, 51, 1),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: g.isRTL ? EdgeInsets.only(right: 20, top: 10) : EdgeInsets.only(left: 20, top: 10),
                                          height: 30,
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            'Grand Concert',
                                            style: Theme.of(context).accentTextTheme.headline2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 20, bottom: 20) : EdgeInsets.only(left: 20, bottom: 20),
                                              child: Row(
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.date_range,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '9 May, 2021',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 10, bottom: 20) : EdgeInsets.only(left: 10, bottom: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.watch_later_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '10PM - 01AM',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 6,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => BuyTicketsScreen(
                                        currentUserId: widget.currentUserId,
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18.5),
                                          child: Image.asset(
                                            'assets/images/plan_dating.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.5),
                                          color: Color.fromRGBO(19, 1, 51, 1),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: g.isRTL ? EdgeInsets.only(right: 20, top: 10) : EdgeInsets.only(left: 20, top: 10),
                                          height: 30,
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            'Grand Concert',
                                            style: Theme.of(context).accentTextTheme.headline2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 20, bottom: 20) : EdgeInsets.only(left: 20, bottom: 20),
                                              child: Row(
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.date_range,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '9 May, 2021',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 10, bottom: 20) : EdgeInsets.only(left: 10, bottom: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.watch_later_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '10PM - 01AM',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 6,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => BuyTicketsScreen(
                                        currentUserId: widget.currentUserId,
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18.5),
                                          child: Image.asset(
                                            'assets/images/plan_dating.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.5),
                                          color: Color.fromRGBO(19, 1, 51, 1),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: g.isRTL ? EdgeInsets.only(right: 20, top: 10) : EdgeInsets.only(left: 20, top: 10),
                                          height: 30,
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            'Grand Concert',
                                            style: Theme.of(context).accentTextTheme.headline2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 20, bottom: 20) : EdgeInsets.only(left: 20, bottom: 20),
                                              child: Row(
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.date_range,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '9 May, 2021',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 10, bottom: 20) : EdgeInsets.only(left: 10, bottom: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.watch_later_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '10PM - 01AM',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 6,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => BuyTicketsScreen(
                                        currentUserId: widget.currentUserId,
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18.5),
                                          child: Image.asset(
                                            'assets/images/plan_dating.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.5),
                                          color: Color.fromRGBO(19, 1, 51, 1),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: g.isRTL ? EdgeInsets.only(right: 20, top: 10) : EdgeInsets.only(left: 20, top: 10),
                                          height: 30,
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            'Grand Concert',
                                            style: Theme.of(context).accentTextTheme.headline2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 20, bottom: 20) : EdgeInsets.only(left: 20, bottom: 20),
                                              child: Row(
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.date_range,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '9 May, 2021',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: g.isRTL ? EdgeInsets.only(right: 10, bottom: 20) : EdgeInsets.only(left: 10, bottom: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ShaderMask(
                                                    blendMode: BlendMode.srcIn,
                                                    shaderCallback: (Rect bounds) {
                                                      return LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(134, 34, 84, 1),
                                                          Color.fromRGBO(72, 53, 133, 1),
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ).createShader(bounds);
                                                    },
                                                    child: Icon(
                                                      Icons.watch_later_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                                    child: Text(
                                                      '10PM - 01AM',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
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
