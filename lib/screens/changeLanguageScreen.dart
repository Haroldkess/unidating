import 'package:uni_dating/l10n/l10n.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/provider/local_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChangeLanguageScreen extends BaseRoute {
  ChangeLanguageScreen({a, o}) : super(a: a, o: o, r: 'ChangeLanguageScreen');
  @override
  _ChangeLanguageScreenState createState() => new _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends BaseRouteState {
  _ChangeLanguageScreenState() : super();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context);
    var locale = provider.locale != null ? Locale('en') : Locale('en') ;
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
            appBar: _appBarWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount: L10n.languageNameList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            activeColor: Theme.of(context).primaryColorLight,
                            value: L10n.all[index].languageCode,
                            groupValue: g.languageCode,
                            onChanged: (val) {
                              g.languageCode = val.toString() ;
                              final provider = Provider.of<LocaleProvider>(context, listen: false);
                              locale = Locale(L10n.all[index].languageCode);
                              provider.setLocale(locale);
                              g.languageCode = locale.languageCode;
                              if (g.rtlLanguageCodeLList.contains(locale.languageCode)) {
                                g.isRTL = true;
                              } else {
                                g.isRTL = false;
                              }
                              setState(() {});
                            },
                            title: Text(
                              L10n.languageNameList[index],
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          index != L10n.languageNameList.length - 1
                              ? Container(
                                  margin: EdgeInsets.only(top: 12, bottom: 12),
                                  height: 1.2,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: g.gradientColors,
                                    ),
                                  ),
                                  child: Divider(),
                                )
                              : SizedBox(),
                        ],
                      );
                    },
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

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.longArrowAltLeft,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Text(
              "AppLocalizations.of(context)!.lbl_lang",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
