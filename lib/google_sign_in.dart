import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_dating/constant_firebase.dart';

import 'model/user_model.dart';

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

    var id;

    await FirebaseAuth.instance.signInWithCredential(credential);

    final user = FirebaseAuth.instance.currentUser!;

    List<String> ids = [];
    bool? exist;
    await usersRef.get().then((value) {
      value.docs.forEach((element) async {
        String id = element.id;
        ids..addAll([id]);
        print("this is the element id $ids");
        if (ids.contains(user.uid.toString()) ||
            (element.id == user.uid.toString()) ||
            id == user.uid) {
          exist = true;
        } else {
          exist = false;
        }

        //   print(exist);
      });
    });

    if (exist == true) {
      print("thia user exist");
      await usersRef.doc(user.uid).update({
        'id': user.uid,
        'onlineStatus': true,
        'onlineOffline': true,
      });
      notifyListeners();

      return;
    }

    if (exist == false) {
      //   print(exist);
      await usersRef.doc(user.uid).set({
        'name': user.displayName,
        'phoneNumber': '',
        'email': user.email,
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
        'filters': ['0', '0'],
        'intrests': ['Photography', 'Music', 'Swimming'],
      });

      await subPeriod.doc(user.uid).set({
        'endDate': Timestamp.now().toDate().subtract(Duration(days: 10)),
        'paid': false,
        'startDate': Timestamp.now().toDate().toLocal(),
        'type': 'null'
      });
    }

    notifyListeners();
  }

  Future anonymous() async {
    // final googleUser = await googleSignIn.signIn();
    // if (googleUser == null) return;
    // _user = googleUser;
    //
    // final googleAuth = await googleUser.authentication;

    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "unidating@gmail.com",
        password: "password"
    );

    var id;



    final user = FirebaseAuth.instance.currentUser!;

    List<String> ids = [];
    bool? exist;
    await usersRef.get().then((value) {
      value.docs.forEach((element) async {
        String id = element.id;
        ids..addAll([id]);
        print("this is the element id $ids");
        if (ids.contains(user.uid.toString()) ||
            (element.id == user.uid.toString()) ||
            id == user.uid) {
          exist = true;
        } else {
          exist = false;
        }

        //   print(exist);
      });
    });

    if (exist == true) {
      print("thia user exist");
      await usersRef.doc(user.uid).update({
        'id': user.uid,
        'onlineStatus': true,
        'onlineOffline': true,
      });
      notifyListeners();

      return;
    }

    if (exist == false) {
      //   print(exist);
      await usersRef.doc(user.uid).set({
        'name': 'test',
        'phoneNumber': '',
        'email': user.email,
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
        'filters': ['0', '0'],
        'intrests': ['Photography', 'Music', 'Swimming'],
      });

      await subPeriod.doc(user.uid).set({
        'endDate': Timestamp.now().toDate().subtract(Duration(days: 10)),
        'paid': false,
        'startDate': Timestamp.now().toDate().toLocal(),
        'type': 'null'
      });
    }

    notifyListeners();
  }

  Future<void> signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    // setState(() {
    //   showLoading = true;
    // });

    final authCredential =
        await _auth.signInWithCredential(phoneAuthCredential);
    var id = PhoneAuthProvider.PROVIDER_ID;
    print("this is your login id $id");

    var user = _auth.currentUser;

    List<String> ids = [];
    bool? exist;

    await usersRef.get().then((value) {
      value.docs.forEach((element) async {
        String id = element.id;
        ids..addAll([id]);
        print("this is the element id $ids");
        if (ids.contains(user!.uid.toString()) ||
            (element.id == user.uid.toString()) ||
            id == user.uid) {
          exist = true;
        } else {
          exist = false;
        }
        //    print(element.id);
      });
    });

    if (exist == true) {
      print("this user exist");
      await usersRef.doc(user!.uid).update({
        'id': user.uid,
        'onlineStatus': true,
        'onlineOffline': true,
      });
      notifyListeners();

      return;
    }

    if (exist == false) {
      //   print(exist);
      await usersRef.doc(user!.uid).set({
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
        'filters': ['0', '0'],
        'intrests': ['Photography', 'Music', 'Swimming'],
      });

      await subPeriod.doc(user.uid).set({
        'endDate': Timestamp.now().toDate().subtract(Duration(days: 10)),
        'paid': false,
        'startDate': Timestamp.now().toDate().toLocal(),
        'type': 'null'
      });
    }

    notifyListeners();
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ProfileDetailScreen(
    //       currentUserId: authCredential.user!.uid,
    //       a: widget.analytics,
    //       o: widget.observer,
    //     )));
  }
}
