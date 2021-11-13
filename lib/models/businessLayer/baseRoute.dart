
import 'package:flutter/material.dart';
import 'package:uni_dating/models/businessLayer/base.dart';
import 'package:uni_dating/model/user_model.dart';


class BaseRoute extends Base {
  final User? user;
  final String? currentUserId;
  BaseRoute({a, o, r, this.user, this.currentUserId}) : super(analytics: a , observer: o , routeName: 'BaseRoute' );

  @override
  BaseRouteState createState() => BaseRouteState();
}

class BaseRouteState extends BaseState with RouteAware {
  BaseRouteState() : super();

  @override
  Widget build(BuildContext context) => null as Widget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
