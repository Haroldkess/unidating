import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';

class User {
  final String? id;
  final String? firstName;
  final String? email;
  final String? lastName;
  final String? phoneNumber;
  final String? userLocation;
  final String? profileImageUrl;
  final List<String>? intrests;
  final int? dob;
  final int? like;
  final int? love;
  final String? gender;
  final String? name;
  final bool? paid;
  final bool? onlineOffline;
  final String? lastMessage;
  final bool? read;
  final String? bio;
  final int? notificationNumber;
  final List<String>? filters;

  User({
    this.id,
    this.firstName,
    this.email,
    this.phoneNumber,
    this.lastName,
    this.userLocation,
    this.profileImageUrl,
    this.intrests,
    this.dob,
    this.gender,
    this.name,
    this.paid,
    this.onlineOffline,
    this.lastMessage,
    this.read,
    this.like,
    this.love,
    this.bio,
    this.notificationNumber,
    this.filters

  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.id,
    //  firstName: doc['firstName'],
    //  lastName: doc['lastName'],
     profileImageUrl: doc['profileImageUrl'],
    //  userLocation: doc["userLocation"],
      phoneNumber: doc['phoneNumber'],
      email: doc['email'],
      intrests: doc['intrests'].cast<String>(),
    dob: doc['dob'],
      gender: doc['gender'],
      name: doc['name'],
      paid: doc['paid'],
      onlineOffline: doc['onlineOffline'],
      lastMessage: doc['lastMessage'],
      read: doc['read'],
      love: doc['love'],
      like: doc['like'],
      notificationNumber: doc['notificationNumber'],
      bio: doc['bio'],
      filters: doc['filters'].cast<String>(),



    );
  }
}

class User2 {
  final String? id;
  final String? firstName;
  final String? email;
  final String? lastName;
  final String? phoneNumber;
  final String? userLocation;
  final String? profileImageUrl;
  final List<String>? intrests;
  final int? dob;
  final int? like;
  final int? love;
  final String? gender;
  final String? name;
  final bool? paid;
  final bool? onlineOffline;
  final String? lastMessage;
  final bool? read;
  final String? bio;

  User2({
    this.id,
    this.firstName,
    this.email,
    this.phoneNumber,
    this.lastName,
    this.userLocation,
    this.profileImageUrl,
    this.intrests,
    this.dob,
    this.gender,
    this.name,
    this.paid,
    this.onlineOffline,
    this.lastMessage,
    this.read,
    this.like,
    this.love,
    this.bio,

  });

  factory User2.fromDoc(DocumentSnapshot doc) {
    return User2(
      id: doc.id,
      // firstName: doc['firstName'],
      // lastName: doc['lastName'],
      profileImageUrl: doc['profileImageUrl'],
      //  userLocation: doc["userLocation"],
      phoneNumber: doc['phoneNumber'],
      email: doc['email'],
      intrests: doc['intrests'].cast<String>(),
      //  dob: doc['dob'],
      // gender: doc['gender'],
      name: doc['name'],
      paid: doc['paid'],
      onlineOffline: doc['onlineOffline'],
      lastMessage: doc['lastMessage'],
      read: doc['read'],
      // love: doc['love'],
      // like: doc['like'],
      // bio: doc['bio'],

    );
  }
}

class User3 {
  final String? id;
  final String? firstName;
  final String? email;
  final String? lastName;
  final String? phoneNumber;
  final String? userLocation;
  final String? profileImageUrl;
  final List<String>? intrests;
  final int? dob;
  final int? like;
  final int? love;
  final String? gender;
  final String? name;
  final bool? paid;
  final bool? onlineOffline;
  final String? lastMessage;
  final bool? read;
  final String? bio;

  User3({
    this.id,
    this.firstName,
    this.email,
    this.phoneNumber,
    this.lastName,
    this.userLocation,
    this.profileImageUrl,
    this.intrests,
    this.dob,
    this.gender,
    this.name,
    this.paid,
    this.onlineOffline,
    this.lastMessage,
    this.read,
    this.like,
    this.love,
    this.bio,

  });

  factory User3.fromDoc(DocumentSnapshot doc) {
    return User3(
      id: doc.id,
      // firstName: doc['firstName'],
      // lastName: doc['lastName'],
      profileImageUrl: doc['profileImageUrl'],
      //  userLocation: doc["userLocation"],
      phoneNumber: doc['phoneNumber'],
      email: doc['email'],
      intrests: doc['intrests'].cast<String>(),
      //  dob: doc['dob'],
      // gender: doc['gender'],
      name: doc['name'],
      paid: doc['paid'],
      onlineOffline: doc['onlineOffline'],
     // lastMessage: doc['lastMessage'],
     // read: doc['read'],
      // love: doc['love'],
      // like: doc['like'],
      // bio: doc['bio'],

    );
  }
}

class UserChat{
  String? id;
  String? senderId;
  String? receiverId;
  String? type;
  String? message;
  Timestamp? timestamp;
  String? photoUrl;
  String? name;
  bool? seen;

  UserChat({
    this.id,
    this.senderId,
    this.receiverId,
    this.type,
    this.timestamp,
    this.message,
    this.photoUrl,
    this.name,
    this.seen

  });

  factory UserChat.fromDoc(DocumentSnapshot doc) {

    return UserChat(
      id: doc.id,
      senderId: doc['senderId'],
      receiverId: doc['receiverId'],
      type: doc['type'],
      timestamp: doc['timestamp'],
      message: doc['message'],
      photoUrl: doc['photoUrl'],
      name: doc['name'],
      seen: doc['seen'],


    );
  }
}




class StatusPost{
  String? id;
  String? text;
  String? name;
  String? profileImage;
  String? type;
  Timestamp? timestamp;

  StatusPost({
    this.id,
    this.text,
    this.name,
    this.profileImage,
    this.type,
    this.timestamp


  });

  factory StatusPost.fromDoc(DocumentSnapshot doc) {

    return StatusPost(
      id: doc.id,
      text: doc['text'],
      name: doc['name'],
      profileImage: doc['profileImage'],
      type: doc['type'],
      timestamp: doc['timestamp']
    );
  }
}



class NotificationList{
  String? id;
  String? profileImage;
  String? text;
  bool? seen;
  String? type;
  String? name;
  Timestamp? timestamp;



  NotificationList({
    this.id,
    this.profileImage,
    this.text,
    this.seen,
    this.type,
    this.name,
    this.timestamp

  });

  factory NotificationList.fromDoc(DocumentSnapshot doc) {

    return NotificationList(
      id: doc.id,
      profileImage: doc['profileImage'],
      text: doc['text'],
      seen: doc['seen'],
      type: doc['type'],
      name: doc['name'],
      timestamp: doc['timestamp'],

    );
  }
}


class ImagePost{
  String? id;
  String? image;

  ImagePost({
    this.id,
    this.image,

  });

  factory ImagePost.fromDoc(DocumentSnapshot doc) {

    return ImagePost(
      id: doc.id,
      image: doc['image'],

    );
  }
}

class AppPayment{
  String? id;
  int? rate;
  double? proX;
  double? starterX;
  double? veteranX;
  bool? hidePayment;
  String? key;

  AppPayment({
    this.id,
    this.rate,
    this.proX,
    this.starterX,
    this.veteranX,
    this.hidePayment,
    this.key
  });

  factory AppPayment.fromDoc(DocumentSnapshot doc) {

    return AppPayment(
      id: doc.id,
      rate: doc['rate'],
      starterX: doc['starterX'],
      proX: doc['proX'],
      veteranX: doc['veteranX'],
      hidePayment: doc['hidePayment'],
      key: doc['key']
    );
  }
}

class SubscriptionPeriod{
  String? id;
  Timestamp? endDate;
  Timestamp? startDate;
  bool? paid;
  String? type;

  SubscriptionPeriod({
    this.id,
    this.endDate,
    this.startDate,
    this.paid,
    this.type,
  });

  factory SubscriptionPeriod.fromDoc(DocumentSnapshot doc) {

    return SubscriptionPeriod(
      id: doc.id,
      endDate: doc['endDate'],
      startDate: doc['startDate'],
      paid: doc['paid'],
      type: doc['type'],

    );
  }
}

class AnonymousComment{
  String? id;
  String? message;
  String? name;
  String? profileImage;
  Timestamp? timestamp;

  AnonymousComment({
    this.id,
    this.message,
    this.name,
    this.profileImage,
    this.timestamp,
  });

  factory AnonymousComment.fromDoc(DocumentSnapshot doc) {

    return AnonymousComment(
      id: doc.id,
      message: doc['message'],
      name: doc['name'],
      profileImage: doc['profileImage'],
      timestamp: doc['timestamp'],

    );
  }
}

