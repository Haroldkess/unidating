import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:uni_dating/widgets/bottomNavigationBarWidgetLight.dart';

class FilterOptionsScreen extends BaseRoute {
  final String? currentUserId;
  final User? thisProfileUser;
  FilterOptionsScreen({a, o,this.currentUserId,this.thisProfileUser}) : super(a: a, o: o, r: 'FilterOptionsScreen');
  @override
  _FilterOptionsScreenState createState() => _FilterOptionsScreenState();
}

class _FilterOptionsScreenState extends BaseRouteState {
  TextEditingController _cLocation = new TextEditingController();
  double values = 18;
  String _ratingController = "English, French, Bengali";
  String _here = 'Make New Friends';
  String _want = 'gender';
  String _ages = "age";
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

  List <String>? filters = [];
  List <String>? ageRange = [];


   Position? _currentPosition;
   String? _currentAddress;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _FilterOptionsScreenState() : super();

  @required
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  int? endValue;
  int? startValue;


  _getCurrentLocation()  {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });



      _getAddressFromLatLng();

    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.administrativeArea}";
      });

      print(place.administrativeArea);
    } catch (e) {
      print(e);
    }
  }

  _submit (){
    usersRef.doc(widget.currentUserId).update({

      'filter': [],
    }).then((_) {
      usersRef.doc(widget.currentUserId).update({
        'filter': filters,

      });

    });
    Navigator.of(context).pop();
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();

  }

  // _getAddressFromLatLng() async {
  //   try {
  //     final position = await _geolocatorPlatform.getLastKnownPosition();
  //     final   p =  geolocator.bearingBetween(
  //         _currentPosition!.latitude, _currentPosition!.longitude,_currentPosition!.latitude,_currentPosition!.longitude);
  //
  //     position place = p[0];
  //
  //     setState(() {
  //       _currentAddress =
  //       "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   //  onTextFieldSubmitted(place.locality);
  //     print(place.locality);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: g.scaffoldBackgroundGradientColors, begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Scaffold(
          appBar: _appBarWidget(),
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "Filter Options",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Manage and set your preferances to find the best matches for you, keep enjoying!",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Want to Meet",
                        style: Theme.of(context).accentTextTheme.headline5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.all(1.2),
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: g.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: g.isDarkModeEnable ? Color(0xFF03000C) : Theme.of(context).scaffoldBackgroundColor,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(Icons.expand_more, color: Theme.of(context).iconTheme.color),
                            ),
                            value: _want,
                            items: ['gender','Women', 'Men']
                                .map((label) => DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text(
                                          label.toString(),
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(_want.isEmpty ? 'Women' : _want),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _want = value!;
                                filters!.add(value);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                       "Prefer Age Range",
                        style: Theme.of(context).accentTextTheme.headline5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.all(1.2),
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: g.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: g.isDarkModeEnable ? Color(0xFF03000C) : Theme.of(context).scaffoldBackgroundColor,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.expand_more,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            value: _ages,
                            items: ['age', '18-25', '26-32', '33-40','41-47','48-55']
                                .map((label) => DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text(
                                          label.toString(),
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                _ages.isNotEmpty ? _ages : '20-35',
                                style: Theme.of(context).primaryTextTheme.subtitle2,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _ages = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Location",
                        style: Theme.of(context).accentTextTheme.headline5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.all(1.2),
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: g.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            color: g.isDarkModeEnable ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                              _currentAddress == null ? '' :   "${_currentAddress!}"
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await _getCurrentLocation();
                                      filters!.add(_currentAddress.toString());
                                    },
                                    child: Icon(
                                      Icons.place,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    g.isDarkModeEnable
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Range",
                              style: Theme.of(context).accentTextTheme.headline5,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Range",
                                  style: Theme.of(context).accentTextTheme.headline5,
                                ),
                                Text(
                                  '0 - ${values.round()} km',
                                  style: Theme.of(context).accentTextTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                    g.isDarkModeEnable
                        ? Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              '0 - ${values.round()} km',
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                          )
                        : SizedBox(),
                    Slider(
                        activeColor: Color.fromRGBO(246, 74, 105, 1),
                        inactiveColor: Color.fromRGBO(35, 4, 254, 0.3),
                        min: 0,
                        max: 1000,
                        value: values,
                        onChangeStart: (value){


                        },
                        onChanged: (value) {

                          setState(() {
                            values = value;

                          });
                        },
                      onChangeEnd: (value){


                      },

                        ),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.all(20),
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
                            if (_ages == '18-25')
                              {
                                filters!.clear();
                                filters!.addAll(['18','19','20','21','22','23','24','25']);
                                _want == 'Men' ? filters!.add('Male') : _want == 'Women' ? filters!.add('Female') : filters!.add(_want) ;
                                filters!.add(_currentAddress!);
                                print(filters.toString());
                                g.isDarkModeEnable
                                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => BottomNavigationWidgetDark(
                                      fromFilters: filters,
                                      currentUserId: widget.currentUserId,
                                      currentIndex: 0,
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )))
                                    : Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => BottomNavigationWidgetLight(
                                      fromFilters: filters,
                                      currentUserId: widget.currentUserId,
                                      currentIndex: 0,
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )
                                ));

                              }
                          else  if (_ages == '26-32')
                            {
                              filters!.clear();
                              filters!.addAll(['26','27','28','29','30','31','32']);
                              _want == 'Men' ? filters!.add('Male') : _want == 'Women' ? filters!.add('Female') : filters!.add(_want) ;
                              filters!.add(_currentAddress!);
                              print(filters.toString());
                              g.isDarkModeEnable
                                  ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetDark(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )))
                                  : Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetLight(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )
                              ));

                            }
                            else  if (_ages == '33-40')
                            {
                              filters!.clear();
                              filters!.addAll(['33','34','35','36','37','38','39','40']);
                              _want == 'Men' ? filters!.add('Male') : _want == 'Women' ? filters!.add('Female') : filters!.add(_want) ;
                              filters!.add(_currentAddress!);
                              print(filters.toString());
                              g.isDarkModeEnable
                                  ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetDark(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )))
                                  : Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetLight(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )
                              ));

                            }
                            else  if (_ages == '41-47')
                            {
                              filters!.clear();
                              filters!.addAll(['41','42','43','44','45','46','47','48']);
                             _want == 'Men' ? filters!.add('Male') : _want == 'Women' ? filters!.add('Female') : filters!.add(_want) ;
                              filters!.add(_currentAddress!);
                              print(filters.toString());
                              g.isDarkModeEnable
                                  ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetDark(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )))
                                  : Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetLight(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )
                              ));

                            }
                            else  if (_ages == '48-55')
                            {
                              filters!.clear();
                              filters!.addAll(['48','49','50','51','52','53','54','55']);
                              _want == 'Men' ? filters!.add('Male') : _want == 'Women' ? filters!.add('Female') : filters!.add(_want) ;
                              filters!.add(_currentAddress!);
                              print(filters.toString());
                              g.isDarkModeEnable
                                  ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetDark(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )))
                                  : Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidgetLight(
                                    fromFilters: filters,
                                    currentUserId: widget.currentUserId,
                                    currentIndex: 0,
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )
                              ));

                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor:
                                Theme.of(context).primaryColorLight,

                                content: Text("Select preferred age range"),
                                //  backgroundColor: Colors.black,
                              ));
                            }




                            // filters.add(value)

                          },
                          child: Text(
                            "Apply Filters",
                            style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                              MaterialState.pressed,
                            }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListTile(
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.longArrowAltLeft),
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              trailing: Icon(
                Icons.refresh,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
