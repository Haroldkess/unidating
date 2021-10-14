import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/datingMatchingScreen.dart';
import 'package:uni_dating/screens/selectPlanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentScreen extends BaseRoute {
  final int screenId;
  PaymentScreen({a, o, required this.screenId}) : super(a: a, o: o, r: 'PaymentScreen');
  @override
  _PaymentScreenState createState() => _PaymentScreenState(this.screenId);
}

class _PaymentScreenState extends BaseRouteState {
  int screenId;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selected = 0;
  _PaymentScreenState(this.screenId) : super();

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.longArrowAltLeft),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SelectPlanScreen(
                        a: widget.analytics,
                        o: widget.observer,
                      )));
            },
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.lbl_payment,
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      AppLocalizations.of(context)!.lbl_payment_subtitle1,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      AppLocalizations.of(context)!.lbl_payment_subtitle2,
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        alignment: Alignment.center,
                        child: RadioListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Colors.transparent,
                          activeColor: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                          subtitle: Text(
                            '**** **** **** 5229',
                            style: Theme.of(context).accentTextTheme.caption,
                          ),
                          value: 0,
                          groupValue: _selected,
                          title: Text('HDFC Credit Card', style: Theme.of(context).primaryTextTheme.subtitle1),
                          onChanged: (int? value) {
                            setState(() async {
                              _selected = value!;
                            });
                          },
                        ),
                      ),
                      Image.asset(
                        'assets/images/master_remove.png',
                        height: 50,
                        width: 60,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 50,
                        width: 200,
                        alignment: Alignment.center,
                        child: RadioListTile(
                          tileColor: Colors.transparent,
                          dense: true,
                          contentPadding: EdgeInsets.all(0),
                          activeColor: g.isDarkModeEnable ? Colors.white : Theme.of(context).primaryColorLight,
                          subtitle: Text(
                            '**** **** **** 4421',
                            style: Theme.of(context).accentTextTheme.caption,
                          ),
                          value: 1,
                          groupValue: _selected,
                          title: Text('ICICI Credit Card', style: Theme.of(context).primaryTextTheme.subtitle1),
                          onChanged: (int? value) {
                            setState(() {
                              _selected = value!;
                            });
                          },
                        ),
                      ),
                      Image.asset(
                        'assets/images/visa_remove.png',
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: g.isDarkModeEnable ? 1.5 : 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: g.gradientColors,
                        ),
                      ),
                      child: Divider(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'UPI Payment',
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                        Text(
                          'Linked',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: g.isDarkModeEnable ? 1.5 : 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: g.gradientColors,
                        ),
                      ),
                      child: Divider(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PayTM / Wallets',
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: g.isDarkModeEnable ? 1.5 : 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: g.gradientColors,
                        ),
                      ),
                      child: Divider(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Net Banking',
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/add icon.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
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
                        AppLocalizations.of(context)!.lbl_add_new_payment_options,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 25),
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
                          screenId == 2
                              ? Navigator.of(context).pop()
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DatingMatchesScreen(
                                        a: widget.analytics,
                                        o: widget.observer,
                                      )));
                        },
                        child: Text(AppLocalizations.of(context)!.btn_pay_now,
                            style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                              MaterialState.pressed,
                            })),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }
}
