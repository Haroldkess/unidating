import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/google_sign_in.dart';
import 'package:uni_dating/model/test_model.dart';

import 'package:uni_dating/models/businessLayer/baseRoute.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;
import 'package:uni_dating/screens/privacy_policy_page.dart';
import 'package:uni_dating/screens/profileDetailScreen.dart';
import 'package:uni_dating/screens/verifyOtpScreen.dart';
import 'package:flutter/material.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends BaseRoute {
  LoginScreen({a, o}) : super(a: a, o: o, r: 'LoginScreen');
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseRouteState {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController _cContactNo = new TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final otpController2 = TextEditingController();
  final otpController3 = TextEditingController();
  final otpController4 = TextEditingController();
  final otpController5 = TextEditingController();
  final otpController6 = TextEditingController();
  String? verId;
  String? phone;
  bool? codeSent = false;
  User? user;

  FocusNode _fNum2 = FocusNode();
  FocusNode _fNum3 = FocusNode();
  FocusNode _fNum4 = FocusNode();
  FocusNode _fNum5 = FocusNode();
  FocusNode _fNum6 = FocusNode();
  FocusNode _fNum7 = FocusNode();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  String? code;

  bool? showLoading = false;

  _LoginScreenState() : super();





  getOtpFromWidget(context){
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Verify",
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            Text(
              "Please enter the 6-digit code",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
            Text(
              "sent to your number",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
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
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum2);

                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
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
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController2,
                      focusNode: _fNum2,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum3);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
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
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController3,
                      focusNode: _fNum3,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum4);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
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
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController4,
                      focusNode: _fNum4,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum5);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
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
                    height: 30,
                    width: 30,
                    child: TextFormField(
                      controller: otpController5,
                      focusNode: _fNum5,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      onChanged: (v) {
                        FocusScope.of(context).requestFocus(_fNum6);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  padding: EdgeInsets.all(1.2),
                  height: 30,
                  width: 30,
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
                    width: 55,
                    child: TextFormField(
                      controller: otpController6,
                      focusNode: _fNum6,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(5)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              width: 150,
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
                  setState(() {
                    code = '${otpController.text+otpController2.text+otpController3.text+otpController4.text+otpController5.text+otpController6.text}';
                  });
                  print(code);
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId!, smsCode: code!);

                  var provider =  Provider.of<GoogleSignInProvider>(context, listen:  false );
                  await  provider.signInWithPhoneAuthCredential(phoneAuthCredential);

               //   signInWithPhoneAuthCredential(phoneAuthCredential);
                  setState(() {
                    user = FirebaseAuth.instance.currentUser!;
                  });



                },
                child: Text(
                  "Submit",
                  style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                    MaterialState.pressed,
                  }),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  getMobileFormWidget(context){
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Login",
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            Text(
              "Please enter your valid mobile number.",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
            Text(
              "We will send you a 4-digit code to verify",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),

            SizedBox(height: 10.0,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "By login in or signing up you accept our T&C.",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "view our terms and conditions here",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicy()));
                      },
                      child: Text("Click here",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold) ,),
                    )
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              padding: EdgeInsets.all(1.5),
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
                child: TextFormField(
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                                Icons.phone
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Phone',
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(4.0),
                          //   child: Icon(
                          //     Icons.expand_more,
                          //     color: Theme.of(context).iconTheme.color,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: VerticalDivider(
                              thickness: 2,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 150,
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
                //  verifyPhone();

                  setState(() {
                    showLoading = true;
                  });

                  await _auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    verificationCompleted: (phoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });
                      //signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    verificationFailed: (verificationFailed) async {
                      ScaffoldMessenger.of(
                          context)
                          .showSnackBar(
                          SnackBar(
                            duration: Duration(
                                seconds: 3),
                            content: Text(
                                verificationFailed.message!),
                            backgroundColor: Theme
                                .of(context)
                                .primaryColorLight,
                          ));

                      setState(() {
                        showLoading = false;
                      });
                      print(verificationFailed.message!);
                      // _scaffoldKey.currentState!.showSnackBar(
                      //     SnackBar(content: Text(verificationFailed.message!)));
                    },
                    codeSent: (verificationId, resendingToken) async {
                      setState(() {
                        showLoading = false;
                        currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {},
                  );

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => VerifyOtpScreen(
                  //       a: widget.analytics,
                  //       o: widget.observer,
                  //     )));
                },
                child: Text(
                  "Submit",
                  style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                    MaterialState.pressed,
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: g.gradientColors,
                      ),
                    ),
                    child: Divider(),
                  ),
                  Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Color(0xFF3F1444),
                        ),
                      ),
                      child: g.isDarkModeEnable
                          ? CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.black,
                        child: Text(
                          "OR",
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      )
                          : CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Text(
                          "OR",
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ))
                ],
              ),
            ),
            Text(
              "Login Using",
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // CircleAvatar(
                  //   radius: 25,
                  //   backgroundColor: Color(0xFF2942C7),
                  //   child: Text(
                  //     'f',
                  //     style: Theme.of(context).accentTextTheme.headline2,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () async {
                      //signInWithPhoneAuthCredential(phoneAuthCredential);

                      var provider =  Provider.of<GoogleSignInProvider>(context, listen:  false );
                      await  provider.googleLogin();
                    },
                    child: Padding(
                      padding: g.isRTL ? const EdgeInsets.only(right: 15) : const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFDF4D5F),
                        child: Text(
                          'G',
                          style: Theme.of(context).accentTextTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getMobileFormWidgetAnonymous(context){
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Login Anonymously",
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            Text(
              "Please enter your valid mobile number.",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
            Text(
              "We will send you a 4-digit code to verify",
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
            SizedBox(height: 10.0,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "By login in or signing up you accept our T&C.",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "view our terms and conditions here",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicy()));
                      },
                      child: Text("Click here",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold) ,),
                    )
                  ],
                ),
              ],
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              padding: EdgeInsets.all(1.5),
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
                child: TextFormField(
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                                Icons.phone
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Phone',
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(4.0),
                          //   child: Icon(
                          //     Icons.expand_more,
                          //     color: Theme.of(context).iconTheme.color,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: VerticalDivider(
                              thickness: 2,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 150,
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
                  var provider =  Provider.of<GoogleSignInProvider>(context, listen:  false );
                  await  provider.anonymous();

                },
                child: Text(
                  "Submit",
                  style: Theme.of(context).textButtonTheme.style!.textStyle!.resolve({
                    MaterialState.pressed,
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: g.gradientColors,
                      ),
                    ),
                    child: Divider(),
                  ),
                  Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Color(0xFF3F1444),
                        ),
                      ),
                      child: g.isDarkModeEnable
                          ? CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.black,
                        child: Text(
                          "OR",
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      )
                          : CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Text(
                          "OR",
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ))
                ],
              ),
            ),
            Text(
              "Login Using",
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // CircleAvatar(
                  //   radius: 25,
                  //   backgroundColor: Color(0xFF2942C7),
                  //   child: Text(
                  //     'f',
                  //     style: Theme.of(context).accentTextTheme.headline2,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () async {
                      var provider =  Provider.of<GoogleSignInProvider>(context, listen:  false );
                      await  provider.anonymous();


                    },
                    child: Padding(
                      padding: g.isRTL ? const EdgeInsets.only(right: 15) : const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFDF4D5F),
                        child: Text(
                          'G',
                          style: Theme.of(context).accentTextTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone() async {
    setState(() {
      phone = phoneController.text;
      showLoading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text.toString(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          final snackBar = SnackBar(content: Text("Login Success"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        verificationFailed: (FirebaseAuthException e) {
          final snackBar = SnackBar(content: Text("${e.message}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            showLoading = false;
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          });
        },

        codeSent: (String? verficationId, int? resendToken) {
          setState(() {
            codeSent = true;
            verId = verficationId;
            showLoading = false;
          });
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verId = verificationId;
              showLoading = false;

          });
        },

        timeout: Duration(seconds: 20),forceResendingToken: 1  );
  }


  Future<void> verifyPin(String pin) async {
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: verId!, smsCode: pin);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      final snackBar = SnackBar(content: Text("Login Success"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text("${e.message}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection("test").doc("test1997").get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                {
                  return Center(child: CircularProgressIndicator());
                }
              Test test = Test.fromDoc(snapshot.data);
              return test.test == false ? Container(
                child: showLoading!
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                    ? getMobileFormWidget(context)
                    : getOtpFromWidget(context),
                padding: const EdgeInsets.all(16),
              ) : Container(
                child:   getMobileFormWidgetAnonymous(context),
                padding: const EdgeInsets.all(16),
              ) ;
            }
          )),
    ));
  }

  @override
  void initState() {
   // Provider.of<GoogleSignInProvider>(context, listen:  false);

    super.initState();
  }
}
