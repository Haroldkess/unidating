import 'package:cached_network_image/cached_network_image.dart';
import 'package:uni_dating/database_codes/database.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uni_dating/screens/interestScreen.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

class NotificationListScreen extends BaseRoute {
  final User? thisProfileUser;
  final String? currentUserId;

  NotificationListScreen({a, o, this.thisProfileUser, this.currentUserId})
      : super(a: a, o: o, r: 'NotificationListScreen');

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _NotificationListScreenState() : super();

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
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notifications",
                  style: Theme.of(context).primaryTextTheme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 20),
                  child: Text(
                    "Check notifications, respond & keep dating",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: DatabaseService.notificationList(
                          widget.currentUserId!),
                      builder: (context, AsyncSnapshot snapshot) {
                        final List<NotificationList>? notificationList =
                            snapshot.data;
                        if (snapshot.data == null || !snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemCount: notificationList!.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: (){
                               if (notificationList[index]
                                   .type == 'Request'){
                                 g.isDarkModeEnable
                                     ? Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context) => BottomNavigationWidgetDark(
                                       currentUserId: widget.currentUserId,
                                       currentIndex: 1,
                                       a: widget.analytics,
                                       o: widget.observer,
                                     )))
                                     : Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context) => BottomNavigationWidgetLight(
                                       currentUserId: widget.currentUserId,
                                       currentIndex: 1,
                                       a: widget.analytics,
                                       o: widget.observer,
                                     )));
                               }

                               else if (notificationList[index]
                                   .type == 'like')
                                 {

                                   ScaffoldMessenger.of(context)
                                       .showSnackBar(SnackBar(
                                     content: Text("Can't view profile"),
                                     backgroundColor:
                                     Theme.of(context).primaryColorLight,
                                     duration: Duration(seconds: 1),
                                   ));


                                 }

                               else if (notificationList[index]
                                   .type == 'message')
                               {
                                 g.isDarkModeEnable
                                     ? Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context) => BottomNavigationWidgetDark(
                                       currentUserId: widget.currentUserId,
                                       currentIndex: 2,
                                       a: widget.analytics,
                                       o: widget.observer,
                                     )))
                                     : Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context) => BottomNavigationWidgetLight(
                                       currentUserId: widget.currentUserId,
                                       currentIndex: 2,
                                       a: widget.analytics,
                                       o: widget.observer,
                                     )));

                               }

                               else{
                                 ScaffoldMessenger.of(context)
                                     .showSnackBar(SnackBar(
                                   content: Text("Not a fan"),
                                   backgroundColor:
                                   Theme.of(context).primaryColorLight,
                                   duration: Duration(seconds: 1),
                                 ));
                               }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 31,
                                          child: CircleAvatar(
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              notificationList[index]
                                                  .profileImage!,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            radius: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: g.isRTL
                                              ? const EdgeInsets.only(right: 12)
                                              : const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notificationList[index].name!,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4, bottom: 4),
                                                child: Text(
                                                  notificationList[index].text!,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                              Text(
                               "${notificationList[index].timestamp!.toDate().day.toString()}|${notificationList[index].timestamp!.toDate().month.toString()}|${notificationList[index].timestamp!.toDate().year.toString()}",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle2,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
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
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
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
