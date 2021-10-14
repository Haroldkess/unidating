import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/paymentScreen.dart';
import 'package:uni_dating/screens/planDatingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyTicketsScreen extends BaseRoute {
  BuyTicketsScreen({a, o}) : super(a: a, o: o, r: 'BuyTicketsScreen');
  @override
  _BuyTicketsScreenState createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends BaseRouteState {
  _BuyTicketsScreenState() : super();

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
                        'assets/images/event_detail.png',
                        fit: BoxFit.fitWidth,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.5),
                        color: Color.fromRGBO(19, 1, 51, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF130032),
                      child: Icon(
                        Icons.place,
                        color: Colors.white,
                        size: 26,
                      ),
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
                    color: Color(0xFF130032),
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width / 2 - 35,
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
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(top: 20, right: 20, bottom: 12) : const EdgeInsets.only(top: 20, left: 20, bottom: 12),
                        child: Text(
                          'Grand Concert',
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: g.isRTL ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                  child: Text(
                                    '9 May, 2021',
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: g.isRTL ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: g.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    Icons.watch_later_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: g.isRTL ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                                  child: Text(
                                    '10PM - 01AM',
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 30) : const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          AppLocalizations.of(context)!.lbl_desc,
                          style: Theme.of(context).primaryTextTheme.headline3,
                        ),
                      ),
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 10) : const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          'Electronic concert will be held near Sabina',
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 20) : const EdgeInsets.only(left: 20),
                            child: Text(
                              'Beach park with dinner,mocktail',
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Text('More..'),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: g.isRTL ? const EdgeInsets.only(right: 20, top: 20) : const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          AppLocalizations.of(context)!.lbl_intrestes_viewers,
                          style: Theme.of(context).primaryTextTheme.headline3,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                      'assets/images/sample3.png',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 40,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        'assets/images/sample3.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 80,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        'assets/images/sample3.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 120,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        'assets/images/sample3.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 160,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        'assets/images/sample3.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 200,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xFF130032),
                                      child: Text(
                                        '+237',
                                        style: Theme.of(context).accentTextTheme.headline4,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: g.gradientColors,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => PaymentScreen(
                                          screenId: 1,
                                          a: widget.analytics,
                                          o: widget.observer,
                                        )));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.btn_buy_tickets,
                                style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                                  MaterialState.pressed,
                                }),
                              ),
                            ),
                          ),
                        ),
                      )
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
              icon: Icon(FontAwesomeIcons.search),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFCC3263),
            width: MediaQuery.of(context).size.width / 2 - 35,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlanDatingScreen(
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
