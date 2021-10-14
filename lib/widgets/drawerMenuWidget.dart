
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';

class DrawerMenuWidget extends BaseRoute {
  DrawerMenuWidget({a, o}) : super(a: a, o: o, r: 'DrawerMenuWidget');
  @override
  _DrawerMenuWidgetState createState() => new _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends BaseRouteState {
  _DrawerMenuWidgetState() : super();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.7,
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
            ),
            child: Drawer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xffD6376E), Color(0xFFAD45B3)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'View Profile',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        MdiIcons.archiveOutline,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Archive Conversation',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Delete Chat',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Clear History',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Search Chat',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        MdiIcons.viewArray,
                        color: Colors.white,
                      ),
                      title: Text(
                        'View Media',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.block,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Block User',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.report,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Report User',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
