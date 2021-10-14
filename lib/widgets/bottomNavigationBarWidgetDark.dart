import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/screens/addMessageScreen.dart';
import 'package:uni_dating/screens/addStoryScreen.dart';
import 'package:uni_dating/screens/addYourStoryScreen.dart';
import 'package:uni_dating/screens/myProfileDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavigationWidgetDark extends BaseRoute {
  final int currentIndex;
  BottomNavigationWidgetDark({a, o, required this.currentIndex}) : super(a: a, o: o, r: 'BottomNavigationWidgetDark');
  @override
  _BottomNavigationWidgetDarkState createState() => new _BottomNavigationWidgetDarkState(this.currentIndex);
}

class _BottomNavigationWidgetDarkState extends BaseRouteState {
  int currentIndex;
  int _currentIndex = 0;
late  TabController _tabController;
  _BottomNavigationWidgetDarkState(this.currentIndex) : super();

  @override
  void dispose() {
    super.dispose();
  }

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF140133),
                    Color(0xFF140132),
                    Color(0xFF140130),
                    Color(0xFF15012F),
                    Color(0xFF160229),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: TabBar(
                labelColor: Colors.white,
                controller: _tabController,
                indicatorWeight: 3,
                indicatorColor: Theme.of(context).primaryColorLight,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 65),
                onTap: (int index) async {
                  _currentIndex = index;
                  setState(() {});
                },
                tabs: [
                  _tabController.index == 0
                      ? Tab(
                          icon: Icon(
                            MdiIcons.cards,
                          ),
                        )
                      : Tab(
                          icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Icon(MdiIcons.cards)),
                        ),
                  _tabController.index == 1
                      ? Tab(
                          icon: Icon(
                            Icons.grid_view,
                         //   Icons.grid_view_rounded,
                          ),
                        )
                      : Tab(
                          icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            Icons.grid_view,
                            //Icons.grid_view_rounded,
                          ),
                        )),
                  _tabController.index == 2
                      ? Tab(
                          icon: Icon(MdiIcons.messageReplyTextOutline),
                        )
                      : Tab(
                          icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(MdiIcons.messageReplyTextOutline),
                        )),
                  _tabController.index == 3
                      ? Tab(
                          icon: Icon(MdiIcons.account),
                        )
                      : Tab(
                          icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Icon(MdiIcons.account)),
                        ),
                ],
              ),
            ),
          ),
          body: _screens().elementAt(_currentIndex),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (currentIndex != null) {
      setState(() {
        _currentIndex = currentIndex;
      });
    }
    _tabController = new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  List<Widget> _screens() => [
        AddStoryScreen(a: widget.analytics, o: widget.observer),
        AddYourStoryScreen(a: widget.analytics, o: widget.observer),
        AddMessageScreen(a: widget.analytics, o: widget.observer),
        MyProfileSceen(a: widget.analytics, o: widget.observer),
      ];
}
