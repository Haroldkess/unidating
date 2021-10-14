import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddTextCreateStory extends BaseRoute {
  AddTextCreateStory({a, o}) : super(a: a, o: o, r: 'AddTextCreateStory');
  @override
  _AddTextCreateStoryState createState() => new _AddTextCreateStoryState();
}

class _AddTextCreateStoryState extends BaseRouteState {
  TextEditingController _cText = new TextEditingController();
  _AddTextCreateStoryState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null!;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: g.gradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Scaffold(
            appBar: _appBarWidget(),
            backgroundColor: Colors.transparent,
            body: Center(
              child: TextFormField(
                maxLines: 10,
                style: Theme.of(context).accentTextTheme.headline2,
                textAlign: TextAlign.center,
                controller: _cText,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.lbl_hint_start_typing,
                    hintStyle: TextStyle(
                      fontSize: 26,
                    )),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(FontAwesomeIcons.longArrowAltLeft),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: g.isRTL ? const EdgeInsets.only(left: 6) : const EdgeInsets.only(right: 6),
              child: Text(
                AppLocalizations.of(context)!.lbl_done,
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
