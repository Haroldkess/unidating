import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/paymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectPlanScreen extends BaseRoute {
  final User? thisProfileUser;
  final String? currentUserId;
  SelectPlanScreen({a, o,this.currentUserId,this.thisProfileUser}) : super(a: a, o: o, r: 'SelectPlanScreen');
  @override
  _SelectPlanScreenState createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends BaseRouteState {
  bool? starterX = false;
  bool? proX = false;
  bool? vetX = false;
  DateTime _starterX = DateTime.now().add(Duration(days: 30));
  DateTime? _proX = DateTime.now().add(Duration(days: 180));
  DateTime? _vetX = DateTime.now().add(Duration(days: 360));

  String _email = 'tlptechfund@gmail.com';
  int _amount = 200;
  String _message = '';

  _SelectPlanScreenState() : super();


  Widget ui (BuildContext context, AsyncSnapshot snapshot,AppPayment paymentAmount, )
  {
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
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "For Best Access",
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Subscribe a Plan",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 6),
                          child: Image.asset(
                            'assets/images/heart.png',
                            height: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      "Top features you will get",
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
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
                            MdiIcons.arrowRight,
                            size: 18,
                            color: g.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 8) : const EdgeInsets.only(left: 8),
                          child: Text(
                            'Find out whos following you',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
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
                            MdiIcons.arrowRight,
                            size: 18,
                            color: g.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 8) : const EdgeInsets.only(left: 8),
                          child: Text(
                            'Contact popular and new users',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
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
                            MdiIcons.arrowRight,
                            size: 18,
                            color: g.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Padding(
                          padding: g.isRTL ? const EdgeInsets.only(right: 8) : const EdgeInsets.only(left: 8),
                          child: Text(
                            'Browse profile invisibily &',
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Text('Many More...'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Select Your Plan',
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        proX = false;
                        vetX = false;
                        starterX = true;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 65,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: (proX == false && starterX == true && vetX == false) ?  g.gradientColors: [Color(0xFFfFffFf), Color(0xFFfFffFf)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),

                      child: Container(
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        alignment: Alignment.centerLeft,
                        height: 65,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 10),
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: [Color(0xFFDFC6FE), Color(0xFFD369D4)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Color(0xFFFF5A90),
                                    size: 26,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Starter X',
                                    style: Theme.of(context).primaryTextTheme.subtitle1,
                                  ),
                                  Text(
                                    '1 Months',
                                    style: Theme.of(context).primaryTextTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                  size: 18,
                                ),
                                Text(
                                  '29.99',
                                  style: TextStyle(
                                    color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        proX = true;
                        vetX = false;
                        starterX = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 65,
                      decoration:  BoxDecoration(
                        gradient: LinearGradient(
                          colors: (proX == true && starterX == false && vetX == false) ?  g.gradientColors: [Color(0xFFfFffFf), Color(0xFFfFffFf)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        height: 65,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 10),
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: [Color(0xFFDFC6FE), Color(0xFFD369D4)] ,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    MdiIcons.diamond,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 26,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pro X',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: g.isDarkModeEnable ? Colors.white : Color(0xFF33196B),
                                    ),
                                  ),
                                  Text(
                                    '6 Months',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                  size: 20,
                                ),
                                Text(
                                  '39.99',
                                  style: TextStyle(
                                    color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        proX = false;
                        vetX = true;
                        starterX = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1.5),
                      height: 65,
                      decoration:BoxDecoration(
                        gradient: LinearGradient(
                          colors: (proX == false && starterX == false && vetX == true) ?  g.gradientColors: [Color(0xFFfFffFf), Color(0xFFfFffFf)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      )
                      ,
                      child: Container(
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Color(0xFF140133) : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 65,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 10),
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: [Color(0xFFDFC6FE), Color(0xFFD369D4)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    MdiIcons.crown,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 26,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Veteran X',
                                    style: Theme.of(context).primaryTextTheme.subtitle1,
                                  ),
                                  Text(
                                    '12 Months',
                                    style: Theme.of(context).primaryTextTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: g.isRTL ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                  size: 18,
                                ),
                                Text(
                                  '49.99',
                                  style: TextStyle(
                                    color: g.isDarkModeEnable ? Colors.yellow[700] : Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
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

                        onPressed: () async {
                          if (paymentAmount.hidePayment == true) return;

                          if (vetX == false && starterX == false && proX == false)
                            {
                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                        "Kindly select a plan"),
                                    backgroundColor: Theme
                                        .of(context)
                                        .primaryColorLight,
                                  ));

                            }
                          else{
                            final charge = Charge()
                              ..email = '${widget.thisProfileUser!.email}'
                              ..amount = vetX == true ? (int.tryParse("${paymentAmount.veteranX!.toInt().toString()}")! *  100 ) * paymentAmount.rate! :
                              starterX == true ? (int.tryParse("${paymentAmount.starterX!.toInt().toString()}")! *  100 ) * paymentAmount.rate!
                                  : proX == true ? (int.tryParse("${paymentAmount.proX!.toInt().toString()}")! *  100 ) * paymentAmount.rate! :
                              0
                              ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';
                            final res =
                            await PaystackClient.checkout(context, charge: charge);

                            if(res.status == true || res.reference != null)
                            {
                              if (starterX == true)
                              {
                                usersRef.doc(widget.currentUserId).update({
                                  'paid': true,
                                }).then((_) {
                                  FirebaseFirestore.instance.collection("paidUsers").doc(widget.currentUserId).set({
                                    'paid': true,
                                    'startDate': Timestamp.now().toDate().toLocal(),
                                    'endDate': _starterX.toUtc().add(Duration(days: 30)),
                                    'type': 'starterX'

                                  });
                                });

                              }
                              if (proX == true)
                              {
                                usersRef.doc(widget.currentUserId).update({
                                  'paid': true,
                                }).then((_) {
                                  FirebaseFirestore.instance.collection("paidUsers").doc(widget.currentUserId).set({
                                    'paid': true,
                                    'startDate': Timestamp.now().toDate().toLocal(),
                                    'endDate': _starterX.toUtc().add(Duration(days: 180)),
                                    'type': 'proX'

                                  });
                                });

                              }
                              if (vetX == true)
                              {
                                usersRef.doc(widget.currentUserId).update({
                                  'paid': true,
                                }).then((_) {
                                  FirebaseFirestore.instance.collection("paidUsers").doc(widget.currentUserId).set({
                                    'paid': true,
                                    'startDate': Timestamp.now().toDate().toLocal(),
                                    'endDate': _starterX.toUtc().add(Duration(days: 365)),
                                    'type': 'vetX'

                                  });
                                });

                              }

                            }


                            if (res.status) {
                              _message = 'Charge was successful. Ref: ${res.reference}';
                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                        _message),
                                    backgroundColor: Theme
                                        .of(context)
                                        .primaryColorLight,
                                  ));

                            } else {
                              _message = 'Failed: ${res.message}';
                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                        _message),
                                    backgroundColor: Theme
                                        .of(context)
                                        .primaryColorLight,
                                  ));
                            }
                            setState(() {});
                          }



                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //     builder: (context) => PaymentScreen(
                          //           screenId: 2,
                          //           a: widget.analytics,
                          //           o: widget.observer,
                          //         )));
                        },
                        child: Text(
                          "Continue",
                          style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                            MaterialState.pressed,
                          }),
                        ),
                      ),
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
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: pricingRef.doc("price1997").get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
        AppPayment _pay = AppPayment.fromDoc(snapshot.data);
        return ui(context, snapshot, _pay);
      },
    );
  }

  String? key;
Future <void> pubKey () async{

await  pricingRef.doc('price1997').get().then((value) {
  String  _data = value.data()!['key'];
    setState(() {
      key = _data;
    });

  });

  await PaystackClient.initialize(key!);

}
  @override
  void initState() {
    super.initState();
    pubKey();
  }
}
