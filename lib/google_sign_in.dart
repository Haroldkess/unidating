import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_dating/constant_firebase.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      final user = FirebaseAuth.instance.currentUser!;
      usersRef.doc().get().then((value) {

        value.reference.snapshots().forEach((element) {
          print(element.id);
          if (element.data()!['id'] == (_user!.id)  || element.data()!['id'] != null ) {
            usersRef.doc(user.uid).update({
              'id': user.uid,
              'onlineStatus': true,
              'onlineOffline': true,

            });
          }
          else {
            usersRef.doc(user.uid).set({
              'name': user.displayName,
              'phoneNumber': '',
              'email': user.email,
              'profileImageUrl': user.photoURL,
              'id': user.uid,
              'onlineStatus': true,
              'paid': false,
              'onlineOffline': true,
              'lastMessage': '',
              'read': false,
              'dob': 0,
              'gender': '',
              'bio': '',
              'like': 0,
              'love': 0,
              'notificationNumber': 0,
              'filters': ['0','0']


            });
          }
        });
      });

    });

    notifyListeners();
  }
  Future<void> signInWithPhoneAuthCredential (
      PhoneAuthCredential phoneAuthCredential) async {
    // setState(() {
    //   showLoading = true;
    // });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
     var id =  PhoneAuthProvider.PROVIDER_ID;
      print("this is your login id $id");

    var user = _auth.currentUser;

      // setState(() {
      //   showLoading = false;
      // });
      print("this is your login id using _auth  ${user!.uid}");

        usersRef.get().then((value) {
          value.docs.forEach((element) {
            print(element.id);

            if (element.id == (user.uid)  ) {
              usersRef.doc(user.uid).update({
                'id': user.uid,
                'onlineStatus': true,
                'onlineOffline': true,

              });
            }
            else {
              usersRef.doc(user.uid).set({
                'name': '',
                'phoneNumber': user.phoneNumber,
                'email': '',
                'profileImageUrl': '',
                'id': user.uid,
                'onlineStatus': true,
                'paid': false,
                'onlineOffline': true,
                'lastMessage': '',
                'read': false,
                'dob': 0,
                'gender': '',
                'bio': '',
                'like': 0,
                'love': 0,
                'notificationNumber': 0,
                'filters': [''],
                'intrests': [''],



              });
              print("created");
            }
          });
        });

        notifyListeners();
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ProfileDetailScreen(
        //       currentUserId: authCredential.user!.uid,
        //       a: widget.analytics,
        //       o: widget.observer,
        //     )));


    } on FirebaseAuthException catch (e) {
      // setState(() {
      //   showLoading = false;
      // });

      // _scaffoldKey.currentState!
      //     .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
