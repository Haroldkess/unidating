import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_dating/constant_firebase.dart';
import 'package:uni_dating/model/user_model.dart';
import 'package:uni_dating/screens/myProfileDetailScreen.dart';

class DatabaseService {

  static Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.doc(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }

  static Future<User2> getNewLoverWithId(User2 userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.doc(userId.id).get();
    if (userDocSnapshot.exists) {
      return User2.fromDoc(userDocSnapshot);
    }
    return User2();
  }
  static Future<User> getNewLoverWithIdProfile(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.doc(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }
  static Future<List<User>> getUniDatingUsers(
      List myInterest, String currentUserId) async {
    // print("$myInterest,   this is my intrest directly from the database");
    QuerySnapshot? uniDatingUsers = await usersRef
        .where("intrests", arrayContainsAny: myInterest)
        .get();

    List<User> users =
        uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();
    return users;
  }

  static Future<List<User>> getUniDatingUsersFromFilters(
      List myInterest, String currentUserId) async {
    // print("$myInterest,   this is my intrest directly from the database");
    QuerySnapshot? uniDatingUsers = await usersRef
        .where("filters", isGreaterThanOrEqualTo: myInterest)
        .get();

    List<User> users =
    uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();
    return users;
  }

  static Future<List<User2>> matchedNotChatted(String currentUserId) async {
    QuerySnapshot? uniDatingUsers =
    await usersRef.doc(currentUserId).collection("Matched").where("startedChatting", isEqualTo: false).limit(10).get();

    List<User2> users =
    uniDatingUsers.docs.map((doc) => User2.fromDoc(doc)).toList();

    return users;
  }

  static Stream <List<User2>> matchedChatted(String currentUserId)  {
   return usersRef.doc(currentUserId).collection("Matched").where("startedChatting", isEqualTo: true)
       .snapshots().map((snapshot) =>  snapshot.docs.map((doc) => User2.fromDoc(doc)).toList());

    // List<User> users =
    // uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();

    // return users;
  }
  static Stream <List<NotificationList>> notificationList(String currentUserId)  {
    return usersRef.doc(currentUserId).collection("notification").orderBy('timestamp',descending: false)
        .snapshots().map((snapshot) =>  snapshot.docs.map((doc) => NotificationList.fromDoc(doc)).toList());

    // List<User> users =
    // uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();

    // return users;
  }

  static Stream <List<AnonymousComment>> anonymousComment(String currentUserId)  {
    return usersRef.doc(currentUserId).collection("secreteMessages").orderBy('timestamp',descending: false)
        .snapshots().map((snapshot) =>  snapshot.docs.map((doc) => AnonymousComment.fromDoc(doc)).toList());

    // List<User> users =
    // uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();

    // return users;
  }

  static Stream <List<ImagePost>> getProfilePosts(String currentUserId)  {
    return usersRef.doc(currentUserId).collection("ImagePost")
        .snapshots().map((snapshot) =>  snapshot.docs.map((doc) => ImagePost.fromDoc(doc)).toList());

    // List<User> users =
    // uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();

    // return users;
  }

  static Stream <List<User>> getUserInterestOnProfile(String currentUserId)  {
    return usersRef.where("id",isEqualTo:  currentUserId)
        .snapshots().map((snapshot) =>  snapshot.docs.map((doc) => User.fromDoc(doc)).toList());

    // List<User> users =
    // uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();

    // return users;
  }

  static Stream <List<User2>> matchedAllChat(String currentUserId)  {
    return usersRef.doc(currentUserId).collection("Matched")
        .snapshots().map((snapshot) =>  snapshot.docs.map((doc) => User2.fromDoc(doc)).toList());

    // List<User> users =
    // uniDatingUsers.docs.map((doc) => User.fromDoc(doc)).toList();

    // return users;
  }


//   static Stream <List<StatusPost>> getMatchedStatus(String currentUserId)  {
//
//
//
// // return usersRef.doc(currentUserId).collection("StatusPost").snapshots();
//
//
//   }



  static Future<List<User3>> getLikedMeRequest(String currentUserId) async {
    QuerySnapshot? uniDatingUsers =
        await usersRef.doc(currentUserId).collection("likedMeRequest").get();

    List<User3> users =
        uniDatingUsers.docs.map((doc) => User3.fromDoc(doc)).toList();

    return users;
  }
  static Future deleteMatchRequest (String currentUserId, String idOfUserRequest) async
  {
   await usersRef.doc(currentUserId).collection("likedMeRequest").doc(idOfUserRequest).delete();

  }

  static Future sendMessages (String currentUserId, String receiversId, String message,User senderUser, ) async
  {
    await usersRef.doc(currentUserId).collection("Matched").doc(receiversId).collection("Messages").add({
      'senderId': currentUserId,
      'receiverId': receiversId,
      'message':  message,
      'type': 'text',
      'timestamp' : Timestamp.now().toDate(),
      'photoUrl': "",
      'name': senderUser.name,
      'seen': false,

    }).then((_) {
      usersRef.doc(currentUserId).collection("Matched").doc(receiversId).update({

        'lastMessage':  message,
        'read': true,

      });

    });

    await usersRef.doc(receiversId).collection("Matched").doc(currentUserId).collection("Messages").add({
      'senderId': currentUserId,
      'receiverId': receiversId,
      'message':  message,
      'type': 'text',
      'timestamp' : Timestamp.now().toDate(),
      'photoUrl': "",
      'name': senderUser.name,
      'seen': false,

    }).then((_) {

      usersRef.doc(receiversId).collection("Matched").doc(currentUserId).update({

        'lastMessage':  message,
        'read': false,

      });

    });

  }

  static Future sendMessagesImage (String currentUserId, String receiversId, String message,User senderUser, ) async
  {
    await usersRef.doc(currentUserId).collection("Matched").doc(receiversId).collection("Messages").add({
      'senderId': currentUserId,
      'receiverId': receiversId,
      'message':  message,
      'type': 'image',
      'timestamp' : Timestamp.now().toDate(),
      'photoUrl': "",
      'name': senderUser.name,
      'seen': false,

    }).then((_) {
      usersRef.doc(currentUserId).collection("Matched").doc(receiversId).update({

        'lastMessage':  message,
        'read': true,

      });

    });

    await usersRef.doc(receiversId).collection("Matched").doc(currentUserId).collection("Messages").add({
      'senderId': currentUserId,
      'receiverId': receiversId,
      'message':  message,
      'type': 'image',
      'timestamp' : Timestamp.now().toDate(),
      'photoUrl': "",
      'name': senderUser.name,
      'seen': false,

    }).then((_) {

      usersRef.doc(receiversId).collection("Matched").doc(currentUserId).update({

        'lastMessage':  message,
        'read': false,

      });

    });

  }
  static Stream<List<UserChat>> getUserChatAsStreams(String userId,String receiverId)  {
    return  usersRef
        .doc(userId)
        .collection('Matched').doc(receiverId).collection("Messages").orderBy('timestamp',descending: false)
        .snapshots().map((snapshot) =>  snapshot.docs.map((doc) => UserChat.fromDoc(doc)).toList());


  }
  static Future acceptMatchRequest (String currentUserId, String idOfUserRequest,
      User thisUser,
      List intrest,
      String name,
      String email,
      String phoneNumber,
      String profileImageUrl,
      bool paid,
      bool onlineStatus) async
  {
    await usersRef.doc(currentUserId).collection("likedMeRequest").doc(idOfUserRequest).delete().then((_){
      usersRef.doc(currentUserId).collection("Matched").doc(idOfUserRequest).set({
        'name': name,
        'id': idOfUserRequest,
        'email': email,
        'phoneNumber': phoneNumber,
        'profileImageUrl': profileImageUrl,
        'intrests': FieldValue.arrayUnion(intrest),
        'currentUserId': currentUserId,
        'onlineOffline': false,
        'startedChatting': false,
        'paid': paid,
        'chatted': false,
        'lastMessage': '',
        'read': false

      });
    });

    await usersRef.doc(idOfUserRequest).collection("Matched").doc(currentUserId).set({
      'name': thisUser.name,
      'id': idOfUserRequest,
      'email': thisUser.email,
      'phoneNumber': thisUser.phoneNumber,
      'profileImageUrl': thisUser.profileImageUrl,
      'intrests': FieldValue.arrayUnion(thisUser.intrests!),
      'currentUserId': thisUser.id,
      'onlineOffline': thisUser.onlineOffline,
      'startedChatting': false,
      'paid': paid,
      'chatted': false,
      'lastMessage': '',
      'read': false


    });

  }

  static Future  addLikedCard(
      User? thisUser,
      String? currentUserId,
      List? intrest,
      String? name,
      String? email,
      String? phoneNumber,
      String? id,
      String? profileImageUrl,
      bool? onlineStatus,
      bool? paid )  async {


    usersRef.doc(currentUserId).collection("likedPersons").doc(id).set({
      'name': name,
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'intrests': FieldValue.arrayUnion(intrest!),
      'currentUserId': currentUserId,
      'onlineOffline': onlineStatus,
      'paid': paid,

    }).then((_) {
      usersRef.doc(id).collection("likedMeRequest").doc(currentUserId).set({
        'name': thisUser!.name,
        'id': thisUser.id,
        'email': thisUser.email,
        'phoneNumber': thisUser.phoneNumber,
        'profileImageUrl': thisUser.profileImageUrl,
        'intrests': FieldValue.arrayUnion(thisUser.intrests!),
        'currentUserId': id,
        'onlineOffline': thisUser.onlineOffline,
        'paid': thisUser.paid,

      });
    });

  await  usersRef.doc(id).collection("notification").add({
      'id': currentUserId ,
      'profileImage': thisUser!.profileImageUrl ,
      'text': 'Is Interested in you',
      'seen': false,
      'type': 'like',
      'name': thisUser.name,
      'timestamp': Timestamp.now().toDate().toLocal(),

    }).then((_) {

      usersRef.doc(id).update({
        'notificationNumber': 1,
      });

    });
  }
}
