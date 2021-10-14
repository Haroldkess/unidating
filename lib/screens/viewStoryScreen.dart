
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;



class ViewStoryScreen extends BaseRoute {
  ViewStoryScreen({a, o}) : super(a: a, o: o, r: 'ViewStoryScreen');
  @override
  _ViewStoryScreenState createState() => new _ViewStoryScreenState();
}

class _ViewStoryScreenState extends BaseRouteState {
  List<StoryItem> storyItems = [
    new StoryItem.pageProviderImage(
      AssetImage(
        'assets/images/view1.png',
      ),
      imageFit: BoxFit.fitWidth,
      duration: Duration(seconds: 30),
    ),
    new StoryItem.pageProviderImage(
      AssetImage(
        'assets/images/view2.png',
      ),
      imageFit: BoxFit.fitWidth,
      duration: Duration(seconds: 30),
    ),
    new StoryItem.pageProviderImage(
      AssetImage(
        'assets/images/view3.png',
      ),
      imageFit: BoxFit.fitWidth,
      duration: Duration(seconds: 30),
    ),
  ];

  _ViewStoryScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null! ;
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
            backgroundColor: g.isDarkModeEnable ? Color(0xFF03000C) : Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 24,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: MediaQuery.of(context).size.height - 24,
                          width: MediaQuery.of(context).size.width,
                          child: StoryView(
                              inline: true,
                              storyItems: storyItems,
                              controller: StoryController(), // pass controller here too
                              repeat: false, // should the stories be slid forever
                              onStoryShow: (s) {},
                              onComplete: () {
                                Navigator.of(context).pop();
                              },
                              onVerticalSwipeComplete: (direction) {}),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.longArrowAltLeft),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CircleAvatar(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height / 100 * 6,
                                      width: MediaQuery.of(context).size.height / 100 * 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/img_circle_0.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Belle Benson',
                                                style: Theme.of(context).accentTextTheme.headline4,
                                              ),
                                              Text(
                                                '5 hours ago',
                                                style: Theme.of(context).textTheme.subtitle1,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomSheet: BottomAppBar(
              color: g.isDarkModeEnable ? Color(0xFF14012F) : Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                        //controller: _cMessage,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: AppLocalizations.of(context)!.lbl_reply_hint,
                          hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      MdiIcons.emoticonHappy,
                      size: 20,
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
  }
}
